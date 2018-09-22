//Pat

import XCTest
@testable import IMDB

final class SearchPresenterTests: XCTestCase {

    private let title = "Test Title"
    private let message = "Test Error"
    private var presenter: SearchPresenter!
    private var view: SearchViewInputMock!
    private var interactor: SearchInteractorInputMock!
    private var router: SearchRouterInputMock!

    override func setUp() {
        super.setUp()
        view = SearchViewInputMock()
        interactor = SearchInteractorInputMock()
        router = SearchRouterInputMock()
        presenter = SearchPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.title = title
    }

    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        presenter = nil
        super.tearDown()
    }

// MARK: - SearchViewOutput

    func testViewIsReady() {
        presenter.viewIsReady()
        XCTAssertEqual(interactor.invocations.count, 1)
        XCTAssertEqual(interactor.invocations[0], .fetchRecentSearch)
    }

    func testSearchTextDidTap() {
        presenter.searchTextDidTap()
        XCTAssertEqual(view.invocations.count, 1)
        XCTAssertEqual(view.invocations[0], .showFocusedLayout)
    }

    func testSearchButtonDidTap() {
        presenter.searchButtonDidTap(title: title)
        XCTAssertEqual(view.invocations.count, 1)
        XCTAssertEqual(view.invocations[0], .showLoading)
        XCTAssertEqual(interactor.invocations.count, 1)
        XCTAssertEqual(interactor.invocations[0], .search(title: title))
    }

    func testRecentSearchDidTap() {
        presenter.recentSearchDidTap(title: title)
        XCTAssertEqual(view.invocations.count, 1)
        XCTAssertEqual(view.invocations[0], .showLoading)
        XCTAssertEqual(interactor.invocations.count, 1)
        XCTAssertEqual(interactor.invocations[0], .search(title: title))
    }

// MARK: - SearchInteractorOutput

    func testSuccess() {
        let expectMovies = [
            MovieModel(
                title: "Test Title",
                posterPath: "/test.photo",
                releaseDate: Date(),
                overview: "Test Overview"
            )
        ]
        let expectFinalPage = false
        presenter.success(
            movies: expectMovies,
            isFinalPage: expectFinalPage
        )
        XCTAssertEqual(view.invocations.count, 2)
        XCTAssertEqual(view.invocations[0], .showNormalLayout)
        XCTAssertEqual(view.invocations[1], .showSuccess)
        XCTAssertEqual(interactor.invocations.count, 2)
        XCTAssertEqual(interactor.invocations[0], .saveRecentSearch(title: title))
        XCTAssertEqual(interactor.invocations[1], .fetchRecentSearch)
        XCTAssertEqual(router.invocations.count, 1)
        XCTAssertEqual(router.invocations[0],
                       .routeToMovieList(
                        searchTitle: title,
                        movies: expectMovies,
                        isFinalPage: expectFinalPage
            )
        )
    }

    func testFailure() {
        presenter.failure(message: message)
        XCTAssertEqual(view.invocations.count, 1)
        XCTAssertEqual(view.invocations[0], .showError(message: message))
    }

    func testSuccessRecentSearch() {
        let expectRecentSearch = [SearchModel(title: title)]
        presenter.success(recentSearch: expectRecentSearch)
        XCTAssertEqual(view.invocations.count, 1)
        XCTAssertEqual(view.invocations[0], .show(recentSearch: expectRecentSearch))
    }
}
