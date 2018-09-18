//Pat

import Foundation

protocol SearchViewInput: class {
    func showLastSearch()
    func showNormalLayout()
    func showFocusedLayout()
    func showLoading()
    func showSuccess()
    func showError()
}

protocol SearchViewOutput: class {
    func searchTextDidTap()
    func searchButtonDidTap()
}

protocol SearchRouterInput: class {
    func routeToResultList(searchTitle: String, movies: [MovieModel])
}

protocol SearchInteractorInput: class {
    func search()
    func lastSearch()
}

protocol SearchInteractorOutput: class {
    func success()
    func failure()
    func lastSearchCompleted()
}
