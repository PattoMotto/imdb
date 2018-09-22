//Pat

import XCTest
@testable import IMDB

final class MovieListInteractorTests: XCTestCase {

    private let title = "Test Title"
    private let message = "Test Error"
    private let page = 2
    private var interactor: MovieListInteractor!
    private var output: MovieListInteractorOutputMock!
    private var service: SearchServiceMock!
    private lazy var expectMovies = [
        MovieModel(
            title: "Test Title",
            posterPath: "/test.photo",
            releaseDate: Date(),
            overview: "Test Overview"
        )
    ]

    override func setUp() {
        super.setUp()
        output = MovieListInteractorOutputMock()
        service = SearchServiceMock()
        interactor = MovieListInteractor()
        interactor.output = output
        interactor.service = service
    }

    override func tearDown() {
        super.tearDown()
        output = nil
        service = nil
        interactor = nil
    }

// MARK: - MovieListInteractorInput

    func testSearch() {
        interactor.search(title: title, page: page)
        XCTAssertEqual(service.invocations.count, 1)
        XCTAssertEqual(service.invocations[0], .search(title: title, page: page))
    }

// MARK: - SearchServiceOutput

    func testSuccessWithNextPage() {
        interactor.success(movies: expectMovies, isFinalPage: false)
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], .success(movies: expectMovies))
    }

    func testSuccessWithLastPage() {
        interactor.success(movies: expectMovies, isFinalPage: true)
        XCTAssertEqual(output.invocations.count, 2)
        XCTAssertEqual(output.invocations[0], .success(movies: expectMovies))
        XCTAssertEqual(output.invocations[1], .isFetchedAllPage)
    }

    func testFailure() {
        interactor.failure(message: message)
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], .failure(message: message))
    }
}
