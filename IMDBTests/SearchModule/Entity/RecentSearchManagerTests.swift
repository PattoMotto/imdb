//Pat

import XCTest
@testable import IMDB

final class RecentSearchManagerTests: XCTestCase {

    private let title = "Test Title"
    private let expectModels = [SearchModel(title: "Test Title")]
    private var recentSearchManager: RecentSearchManager!
    private var searchModelStorage: SearchModelStorageMock!

    override func setUp() {
        super.setUp()
        searchModelStorage = SearchModelStorageMock()
        searchModelStorage.mockSearchModels = expectModels
        recentSearchManager = RecentSearchManagerImpl(store: searchModelStorage)
    }

    override func tearDown() {
        searchModelStorage = nil
        recentSearchManager = nil
        super.tearDown()
    }

    func testSave() {
        recentSearchManager.save(title: title)
        XCTAssertEqual(searchModelStorage.invocations.count, 2)
        XCTAssertEqual(searchModelStorage.invocations[0], .read)
        XCTAssertEqual(searchModelStorage.invocations[1], .write)
    }

    func testRecentSearch() {
        XCTAssertEqual(recentSearchManager.recentSearch(), expectModels)
        XCTAssertEqual(searchModelStorage.invocations.count, 1)
        XCTAssertEqual(searchModelStorage.invocations[0], .read)
    }
}
