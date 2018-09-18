//Pat

import Foundation

final class MovieListPresenter {
    weak var view: MovieListViewInput?
    var movies: [MovieModel] = []
    var title = ""
}

extension MovieListPresenter: MovieListViewOutput {

    func viewIsReady() {
        view?.showTitle(title: title)
        view?.showMovieList(movies: movies)
    }

    func reachLastCell() {

    }
}
