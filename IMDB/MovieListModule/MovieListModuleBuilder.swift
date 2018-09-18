//Pat

import Foundation

struct MovieListModuleBuilder {

    static func build(searchTitle: String,
                      movies: [MovieModel]) -> MovieListViewController {
        let viewController = MovieListViewController()
        let presenter = MovieListPresenter()

        presenter.title = searchTitle
        presenter.movies = movies
        presenter.view = viewController
        viewController.output = presenter

        return viewController
    }
}
