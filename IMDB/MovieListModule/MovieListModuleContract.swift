//Pat

import Foundation

protocol MovieListViewInput: class {
    func showMovieList(movies: [MovieModel])
    func isFetchedAllPage()
    func showTitle(title: String)
}

protocol MovieListViewOutput: class {
    func viewIsReady()
    func reachLastCell()
}
