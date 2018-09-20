//Pat

import XCTest
@testable import IMDB

final class SearchRouterTests: XCTestCase {

    private var navigationController: NavigationControllerMock!
    private var viewController: ViewControllerMock!
    private var router: SearchRouter!

    override func setUp() {
        super.setUp()
        navigationController = NavigationControllerMock()
        viewController = ViewControllerMock()
        viewController.mockNavigationController = navigationController
        router = SearchRouter()
        router.viewController = viewController
    }

    override func tearDown() {
        viewController = nil
        router = nil
        super.tearDown()
    }

    func testRouteToMovieList() {
        router.routeToMovieList(
            searchTitle: "Test Title",
            movies: [],
            isFinalPage: true
        )
        XCTAssertEqual(navigationController.invocations.count, 1)
        XCTAssertEqual(navigationController.invocations[0], .pushViewController)
        XCTAssertEqual(viewController.invocations.count, 0)
    }
}
