//Pat

import XCTest
@testable import IMDB

final class MovieModelMapperTests: XCTestCase {

    private let expectMovie = MovieModel(
        title: "Test Title",
        posterPath: "/test.photo",
        // swiftlint:disable:next force_unwrapping
        releaseDate: Date.fromYYYYDDMM(value: "1989-06-23")!,
        overview: "Test Overview"
    )

    private lazy var json = ["title": "Test Title",
                             "poster_path": "/test.photo",
                             "release_date": "1989-06-23",
                             "overview": "Test Overview"]

    private lazy var jsonArray = [
        ["title": "Test Title",
         "poster_path": "/test.photo",
         "release_date": "1989-06-23",
         "overview": "Test Overview"]
    ]

    func testMapperFromJson() {
        let movieModelMapper = MovieModelMapperImpl()
        let movie = movieModelMapper.fromJson(json: json)
        XCTAssertEqual(movie, expectMovie)
    }

    func testMapperFromJsonArray() {
        let movieModelMapper = MovieModelMapperImpl()
        let movies = movieModelMapper.fromJsonArray(jsonArray: jsonArray)
        XCTAssertEqual(movies, [expectMovie])
    }
}
