//Pat

import XCTest
@testable import IMDB

class MovieListModuleBuilderTests: XCTestCase {

    func testBuilder() {
        let expectTitle = "Test Title"
        let expectMovies = [
            MovieModel(
                title: "Test Title",
                posterPath: "/test.photo",
                releaseDate: Date(),
                overview: "Test Overview"
            )
        ]
        let expectFinalPage = true
        let viewController = MovieListModuleBuilder.build(
            searchTitle: expectTitle,
            movies: expectMovies,
            isFinalPage: true
        )
        let presenter = viewController.output as? MovieListPresenter
        let interactor = presenter?.interactor as? MovieListInteractor

        XCTAssertNotNil(viewController)
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(interactor)
        XCTAssertEqual(presenter?.title, expectTitle)
        //swiftlint:disable:next force_unwrapping
        XCTAssertEqual((presenter?.movies)!, expectMovies)
        XCTAssertEqual(presenter?.isFinalPage, expectFinalPage)
    }
}
