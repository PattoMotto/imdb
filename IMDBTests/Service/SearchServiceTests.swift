//Pat

import XCTest
import Alamofire
@testable import IMDB

class SearchServiceTests: XCTestCase {

    var searchService: SearchService!
    var coreApi: CoreApiMock!
    var output: SearchServiceOutputMock!

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
}
