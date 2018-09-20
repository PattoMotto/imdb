//Pat

import XCTest
@testable import IMDB

final class SearchInteractorTests: XCTestCase {

    private let title = "Test Title"
    private let message = "Test Error"
    private var interactor: SearchInteractor!
    private var output: SearchInteractorOutputMock!
    private var recentSearchManager: RecentSearchManagerMock!
    private var service: SearchServiceMock!

    override func setUp() {
        super.setUp()
        output = SearchInteractorOutputMock()
        recentSearchManager = RecentSearchManagerMock()
        service = SearchServiceMock()
        interactor = SearchInteractor()
        interactor.output = output
        interactor.recentSearchManager = recentSearchManager
        interactor.service = service
    }

    override func tearDown() {
        output = nil
        recentSearchManager = nil
        service = nil
        interactor = nil

        super.tearDown()
    }

// MARK: - SearchInteractorInput

    func testSearch() {
        interactor.search(title: title)
        XCTAssertEqual(service.invocations.count, 1)
        XCTAssertEqual(service.invocations[0], .search(title: title, page: 1))
    }

    func testFetchRecentSearch() {
        let expectRecentSearch = [SearchModel(title: title)]
        recentSearchManager.mockRecentSearch = expectRecentSearch
        interactor.fetchRecentSearch()
        XCTAssertEqual(recentSearchManager.invocations.count, 1)
        XCTAssertEqual(recentSearchManager.invocations[0], .recentSearch)
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], .successRecentSearch(expectRecentSearch))
    }

    func testSaveRecentSearch(title: String) {
        interactor.saveRecentSearch(title: title)
        XCTAssertEqual(recentSearchManager.invocations.count, 1)
        XCTAssertEqual(recentSearchManager.invocations[0], .save(title: title))
    }

// MARK: - SearchServiceOutput

    func testSuccess() {
        let expectMovies: [MovieModel] = []
        let expectFinalPage = false
        interactor.success(
            movies: expectMovies,
            isFinalPage: expectFinalPage
        )
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0],
                       .success(movies: expectMovies, isFinalPage: expectFinalPage))
    }

    func testFailure() {
        interactor.failure(message: message)
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], .failure(message: message))
    }
}
