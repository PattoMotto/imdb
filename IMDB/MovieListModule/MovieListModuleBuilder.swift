//Pat

import Foundation

struct MovieListModuleBuilder {

    static func build(searchTitle: String,
                      movies: [MovieModel],
                      isFinalPage: Bool) -> MovieListViewController {
        let viewController = MovieListViewController()
        let presenter = MovieListPresenter()
        let interactor = MovieListInteractor()
        let service = SearchServiceImpl(output: interactor)

        presenter.title = searchTitle
        presenter.movies = movies
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.isFinalPage = isFinalPage
        interactor.output = presenter
        interactor.service = service
        viewController.output = presenter

        return viewController
    }
}
