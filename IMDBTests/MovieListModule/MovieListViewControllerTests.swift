//Pat

import XCTest
@testable import IMDB

final class MovieListViewControllerTests: XCTestCase {

    private var viewController: MovieListViewController!
    private var output: MovieListViewOutputMock!

    override func setUp() {
        super.setUp()
        output = MovieListViewOutputMock()
        viewController = MovieListViewController()
        viewController.output = output
        _ = viewController.view
    }

    override func tearDown() {
        output = nil
        viewController = nil
        super.tearDown()
    }

    func testViewDidLoad() {
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], .viewIsReady)
    }

    func testDidScrollToBottom() {
        let expectMovies = (1...10).map {
            MovieModel(
                title: "Test Title\($0)",
                posterPath: "/test.photo",
                releaseDate: Date(),
                overview: "Test Overview"
            )
        }
        viewController.showMovieList(movies: expectMovies)
        (0...9).forEach {
            _ = viewController.tableView(
                viewController.tableView,
                cellForRowAt: IndexPath(row: $0, section: 0)
            )
        }
        XCTAssertEqual(output.invocations.count, 2)
        XCTAssertEqual(output.invocations[0], .viewIsReady)
        XCTAssertEqual(output.invocations[1], .didScrollToBottom)
    }
}
