//Pat

import Foundation

final class SearchInteractor {
    weak var output: SearchInteractorOutput?
    var service: SearchService?
    var recentSearchManager: RecentSearchManager?
}

extension SearchInteractor: SearchInteractorInput {
    func search(title: String) {
        service?.search(title: title, page: 1)
    }

    func fetchRecentSearch() {
        guard let recentSearch = recentSearchManager?.recentSearch() else { return }
        output?.success(recentSearch: recentSearch)
    }

    func saveRecentSearch(title: String) {
        recentSearchManager?.save(title: title)
    }
}

extension SearchInteractor: SearchServiceOutput {
    func success(movies: [MovieModel], isFinalPage: Bool) {
        output?.success(movies: movies, isFinalPage: isFinalPage)
    }
    
    func failure(errorMessage: String) {
        output?.failure(message: errorMessage)
    }
}

extension SearchInteractor {
    private var randomBool: Bool {
        return arc4random_uniform(2) == 0
    }
}
