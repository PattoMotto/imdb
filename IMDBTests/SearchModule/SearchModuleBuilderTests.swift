//Pat

import XCTest
@testable import IMDB

final class SearchModuleBuilderTests: XCTestCase {

    func testBuilder() {
        let viewController = SearchModuleBuilder.build()
        let presenter = viewController.output as? SearchPresenter
        let router = presenter?.router as? SearchRouter
        let interactor = presenter?.interactor as? SearchInteractor
        let service = interactor?.service
        let recentSearchManager = interactor?.recentSearchManager

        XCTAssertNotNil(viewController)
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(router)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(service)
        XCTAssertNotNil(recentSearchManager)
    }
}
