//Pat

import Foundation

final class SearchPresenter {
    weak var view: SearchViewInput?
    var router: SearchRouterInput?
    var interactor: SearchInteractorInput?
    var page = 1
    var title = ""

    private func search(title: String) {
        view?.showLoading()
        self.title = title
        interactor?.search(title: title)
    }
}

extension SearchPresenter: SearchViewOutput {
    func viewIsReady() {
        interactor?.fetchRecentSearch()
    }

    func searchTextDidTap() {
        view?.showFocusedLayout()
    }

    func searchButtonDidTap(title: String) {
        search(title: title)
    }

    func recentSearchDidTap(title: String) {
        search(title: title)
    }
}

extension SearchPresenter: SearchInteractorOutput {
    func success(movies: [MovieModel], isFinalPage: Bool) {
        view?.showNormalLayout()
        view?.showSuccess()
        interactor?.saveRecentSearch(title: title)
        interactor?.fetchRecentSearch()
        router?.routeToResultList(
            searchTitle: title,
            movies: movies,
            isFinalPage: isFinalPage
        )
    }

    func failure(message: String) {
        view?.showError(message: message)
    }

    func success(recentSearch: [SearchModel]) {
        view?.show(recentSearch: recentSearch)
    }
}
