//Pat

import Foundation

struct SearchModuleBuilder {

    static func build() -> SearchViewController {
        let viewController = SearchViewController()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        let interactor = SearchInteractor()
        let service = SearchServiceImpl(output: interactor)
        let recentSearchManager = RecentSearchManagerImpl()

        viewController.output = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.output = presenter
        interactor.service = service
        interactor.recentSearchManager = recentSearchManager
        router.viewController = viewController

        return viewController
    }
}
