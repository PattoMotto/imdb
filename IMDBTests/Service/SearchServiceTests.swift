//Pat

import XCTest
import Alamofire
@testable import IMDB

class SearchServiceTests: XCTestCase {

    private let emptyResult = "Empty result"
    private var searchService: SearchService!
    private var coreApi: CoreApiMock!
    private var output: SearchServiceOutputMock!

    override func setUp() {
        super.setUp()
        coreApi = CoreApiMock()
        output = SearchServiceOutputMock()
        searchService = SearchServiceImpl(
            coreApi: coreApi,
            output: output
        )
    }

    override func tearDown() {
        coreApi = nil
        output = nil
        searchService = nil
        super.tearDown()
    }

    func testSearch() {
        let expectTitle = "Test Title"
        let expectPage = 1
        // swiftlint:disable:next force_unwrapping
        let expectUrl = URL(string: "https://api.themoviedb.org/3/search/movie")!
        let expectParameters: Parameters = [
            "query": expectTitle,
            "page": expectPage
        ]
        searchService.search(title: expectTitle, page: expectPage)
        XCTAssertEqual(coreApi.invocations.count, 1)
        XCTAssertEqual(coreApi.invocations[0],
                       .get(url: expectUrl, parameters: expectParameters))
    }

    func testSuccessLastPage() {
        let expectTitle = "Test Title"
        let expectPage = 1
        let results = [["title": "Test Title",
                        "poster_path": "/test.photo",
                        "release_date": "1989-06-23",
                        "overview": "Test Overview"]]
        let resultJson = ["total_pages": 1,
                          "results": results] as [String: Any]
        let movies = [
            MovieModel(
                title: "Test Title",
                posterPath: "/test.photo",
                // swiftlint:disable:next force_unwrapping
                releaseDate: Date.fromYYYYMMDD(value: "1989-06-23")!,
                overview: "Test Overview")
        ]
        coreApi.mockResponse = DataResponse(
            request: nil,
            response: nil,
            data: nil,
            result: Result.success(resultJson))
        searchService.search(title: expectTitle, page: expectPage)
        XCTAssertEqual(output.invocations[0], .success(movies: movies, isFinalPage: true))
    }

    func testSuccessMultiplePages() {
        let expectTitle = "Test Title"
        let expectPage = 1
        let results = [["title": "Test Title",
                        "poster_path": "/test.photo",
                        "release_date": "1992-12-15",
                        "overview": "Test Overview"]]
        let resultJson = ["total_pages": 10,
                          "results": results] as [String: Any]
        let movies = [
            MovieModel(
                title: "Test Title",
                posterPath: "/test.photo",
                // swiftlint:disable:next force_unwrapping
                releaseDate: Date.fromYYYYMMDD(value: "1992-12-15")!,
                overview: "Test Overview")
        ]
        coreApi.mockResponse = DataResponse(
            request: nil,
            response: nil,
            data: nil,
            result: Result.success(resultJson))
        searchService.search(title: expectTitle, page: expectPage)
        XCTAssertEqual(output.invocations[0], .success(movies: movies, isFinalPage: false))
    }

    func testEmptyResult() {
        let expectTitle = "Test Title"
        let expectPage = 1
        let resultJson = ["total_pages": 1,
                          "results": [[:]]] as [String: Any]
        coreApi.mockResponse = DataResponse(
            request: nil,
            response: nil,
            data: nil,
            result: Result.success(resultJson))
        searchService.search(title: expectTitle, page: expectPage)
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], .failure(message: emptyResult))
    }
}
