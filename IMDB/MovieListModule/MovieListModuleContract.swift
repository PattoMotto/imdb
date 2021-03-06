//Pat

import Foundation

protocol MovieListViewInput: class {

    func showMovieList(movies: [MovieModel])
    func showTitle(title: String)
    func showLoading()
    func showSuccess()
    func showError(message: String)
}

protocol MovieListViewOutput: class {

    func viewIsReady()
    func didScrollToBottom()
}

protocol MovieListInteractorInput: class {

    func search(title: String, page: Int)
}

protocol MovieListInteractorOutput: class {

    func success(movies: [MovieModel])
    func failure(message: String)
    func isFetchedAllPage()
}
