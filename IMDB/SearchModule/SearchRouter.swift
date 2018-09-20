//Pat

import Foundation
import UIKit

final class SearchRouter {
    weak var viewController: UIViewController?
}

extension SearchRouter: SearchRouterInput {
    func routeToMovieList(searchTitle: String,
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
