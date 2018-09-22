//Pat

import XCTest
@testable import IMDB

final class MovieListPresenterTests: XCTestCase {

    private var presenter: MovieListPresenter!
    private var view: MovieListViewInputMock!
    private var interactor: MovieListInteractorInputMock!
    private let title = "Test Title"
    private let message = "Test Error"
    private let movies = [
        MovieModel(
            title: "Test Title",
            posterPath: "/test.photo",
            releaseDate: Date(),
            overview: "Test Overview"
        )
    ]

    override func setUp() {
        super.setUp()
        view = MovieListViewInputMock()
        interactor = MovieListInteractorInputMock()
        presenter = MovieListPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.title = title
        presenter.movies = movies
        presenter.isFinalPage = false
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        interactor = nil
        presenter = nil
    }

// MARK: - MovieListViewOutput

    func testViewIsReady() {
        presenter.viewIsReady()
        XCTAssertEqual(view.invocations.count, 2)
        XCTAssertEqual(view.invocations[0], .showTitle(title: title))
        XCTAssertEqual(view.invocations[1], .showMovieList(movies: movies))
    }

    func testDidScrollToBottom() {
        presenter.didScrollToBottom()
        XCTAssertEqual(interactor.invocations.count, 1)
        XCTAssertEqual(interactor.invocations[0], .search(title: title, page: 2))
    }

    func testDidScrollToBottomShouldNotInvokeTwice() {
        presenter.didScrollToBottom()
        presenter.didScrollToBottom()
        XCTAssertEqual(interactor.invocations.count, 1)
        XCTAssertEqual(interactor.invocations[0], .search(title: title, page: 2))
    }

    func testDidScrollToBottomShouldNotInvoke() {
        presenter.isFinalPage = true
        presenter.didScrollToBottom()
        XCTAssertEqual(interactor.invocations.count, 0)
    }

// MARK: - MovieListInteractorOutput

    func testSuccess() {
        presenter.success(movies: movies)
        XCTAssertEqual(presenter.movies.count, 2)
        XCTAssertEqual(view.invocations.count, 1)
        XCTAssertEqual(view.invocations[0],
                       // swiftlint:disable:next force_unwrapping
                       .showMovieList(movies: [movies.first!, movies.first!]))
    }

    func testFailure() {
        presenter.failure(message: message)
        XCTAssertEqual(view.invocations.count, 1)
        XCTAssertEqual(view.invocations[0], .showError(message: message))
    }

    func testIsFetchedAllPage() {
        presenter.isFetchedAllPage()
        XCTAssertTrue(presenter.isFinalPage)
    }
}
