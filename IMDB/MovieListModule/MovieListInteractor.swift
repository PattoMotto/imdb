//Pat

import Foundation

final class MovieListInteractor {
    var service: SearchService?
    var output: MovieListInteractorOutput?
}

extension MovieListInteractor: MovieListInteractorInput {
    func search(title: String, page: Int) {
        service?.search(title: title, page: page)
    }
}

extension MovieListInteractor: SearchServiceOutput {
    func success(movies: [MovieModel], isFinalPage: Bool) {
        output?.success(movies: movies)
        if isFinalPage {
            output?.isFetchedAllPage()
        }
    }

    func failure(errorMessage: String) {
        output?.failure(message: errorMessage)
    }
}
