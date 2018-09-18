//Pat

import Foundation

protocol SearchViewInput: class {
    func show(recentSearch: [SearchModel])
    func showNormalLayout()
    func showFocusedLayout()
    func showLoading()
    func showSuccess()
    func showError(message: String)
}

protocol SearchViewOutput: class {
    func viewIsReady()
    func searchTextDidTap()
    func searchButtonDidTap(title: String)
    func recentSearchDidTap(title: String)
}

protocol SearchRouterInput: class {
    func routeToResultList(searchTitle: String,
                           movies: [MovieModel],
                           isFinalPage: Bool)
}

protocol SearchInteractorInput: class {
    func search(title: String)
    func fetchRecentSearch()
    func saveRecentSearch(title: String)
}

protocol SearchInteractorOutput: class {
    func success(movies: [MovieModel], isFinalPage: Bool)
    func failure(message: String)
    func success(recentSearch: [SearchModel])
}
