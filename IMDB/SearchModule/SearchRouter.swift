//Pat

import Foundation

final class SearchRouter {
    weak var viewController: SearchViewController?
}

extension SearchRouter: SearchRouterInput {
    func routeToResultList(searchTitle: String,
                           movies: [MovieModel],
                           isFinalPage: Bool) {
        let movieListVC = MovieListModuleBuilder.build(
            searchTitle: searchTitle,
            movies: movies,
            isFinalPage: isFinalPage
        )
        guard let navigationController = viewController?.navigationController else {
            return
        }
        navigationController.pushViewController(movieListVC, animated: true)
    }
}
