//Pat

import Foundation

final class MovieListPresenter {
    weak var view: MovieListViewInput?
    var interactor: MovieListInteractorInput?
    var movies: [MovieModel] = []
    var title = ""
    var isFinalPage = false
    private var page = 1
    private var loading = false
}

extension MovieListPresenter: MovieListViewOutput {

    func viewIsReady() {
        view?.showTitle(title: title)
        view?.showMovieList(movies: movies)
    }

    func didScrollToBottom() {
        guard !isFinalPage,
            !loading else { return }
        loading = true
        interactor?.search(title: title, page: page+1)
    }
}

extension MovieListPresenter: MovieListInteractorOutput {
    func success(movies: [MovieModel]) {
        loading = false
        page+=1
        self.movies.append(contentsOf: movies)
        view?.showMovieList(movies: self.movies)
    }

    func failure(message: String) {
        loading = false
        view?.showError(message: message)
    }

    func isFetchedAllPage() {
        isFinalPage = true
    }
}
