//Pat

import Foundation

protocol SearchService {
    func search(title: String, page: Int)
}

protocol SearchServiceOutput {
    func success(movies: [MovieModel], isFinalPage: Bool)
    func failure(message: String)
}

struct SearchError {
    static let malformedResponse = "Malformed Response"
    static let unknownError = "Unknown Error"
    static let emptyResult = "Empty result"
}

final class SearchServiceImpl: SearchService {

    private let endpoint = "https://api.themoviedb.org/3/search/movie"
    private let coreApi: CoreApi
    private let output: SearchServiceOutput

    private struct SearchKey {
        static let query = "query"
        static let page = "page"
        static let results = "results"
        static let totalPages = "total_pages"
    }

    init(coreApi: CoreApi = CoreApiImpl(), output: SearchServiceOutput) {
        self.coreApi = coreApi
        self.output = output
    }

    func search(title: String, page: Int = 1) {
        let parameters = [SearchKey.query: title,
                          SearchKey.page: page] as [String: Any]
        guard let url = URL(string: endpoint) else { return }
        coreApi.get(
            url: url,
            parameters: parameters) { [weak self] response in
                guard let strongSelf = self else { return }
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any],
                        let resultList = json[SearchKey.results]  as? [[String: Any]],
                        let totalPages = json[SearchKey.totalPages] as? Int {
                        let mapper = MovieModelMapperImpl()
                        let movies = mapper.fromJsonArray(jsonArray: resultList).flatMap { $0 }
                        if movies.isEmpty {
                            strongSelf.output.failure(message: SearchError.emptyResult)
                        } else {
                            strongSelf.output.success(movies: movies, isFinalPage: page >= totalPages)
                        }
                    } else {
                        strongSelf.output.failure(message: SearchError.malformedResponse)
                    }
                case .failure(let error):
                    if let error = error as? URLError {
                        strongSelf.output.failure(message: error.localizedDescription)
                    } else {
                        strongSelf.output.failure(message: SearchError.unknownError)
                    }
                }
        }
    }

}
