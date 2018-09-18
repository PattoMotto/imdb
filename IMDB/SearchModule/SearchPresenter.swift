//Pat

import Foundation

final class SearchPresenter {
    weak var view: SearchViewInput?
    var router: SearchRouterInput?
    var interactor: SearchInteractorInput?
}

extension SearchPresenter: SearchViewOutput {
    func searchTextDidTap() {
        view?.showFocusedLayout()
        interactor?.lastSearch()
    }

    func searchButtonDidTap() {
        view?.showFocusedLayout()
        view?.showLoading()
        interactor?.search()
    }
}

extension SearchPresenter: SearchInteractorOutput {
    func success() {
        view?.showNormalLayout()
        view?.showSuccess()
        let movies = (0...100).map { _ in
            MovieModel(title: "Batman", posterPath: "/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg", releaseDate: Date(), overview: "The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker, who has seized control of Gotham's underworld.")
        }
        router?.routeToResultList(searchTitle: "TEST title", movies: movies)
    }

    func failure() {
        view?.showError()
    }

    func lastSearchCompleted() {
        view?.showLastSearch()
    }
}
