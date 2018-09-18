//Pat

import Foundation

struct SearchModuleBuilder {

    static func build() -> SearchViewController {
        let viewController = SearchViewController()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        let interactor = SearchInteractor()

        viewController.output = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.output = presenter
        router.viewController = viewController

        return viewController
    }
}
