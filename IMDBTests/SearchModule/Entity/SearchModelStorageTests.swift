//Pat

import XCTest
@testable import IMDB

final class SearchModelStorageTests: XCTestCase {

    private let key = "IMDB.search.recent"
    private var searchModelStorage: SearchModelStorage!
    private var coreStorage: CoreStorageMock!

    override func setUp() {
        super.setUp()
        coreStorage = CoreStorageMock()
        searchModelStorage = SearchModelStorageImpl(storage: coreStorage)
    }

    override func tearDown() {
        coreStorage = nil
        searchModelStorage = nil
        super.tearDown()
    }

    func testRead() {
        _ = searchModelStorage.read()
        XCTAssertEqual(coreStorage.invocations.count, 1)
        XCTAssertEqual(coreStorage.invocations[0],
                       .readGeneric(key: key))
    }

    func testWrite() {
        let expectModels = [SearchModel(title: "Test title")]
        _ = searchModelStorage.write(value: expectModels)
        XCTAssertEqual(coreStorage.invocations.count, 1)
        XCTAssertEqual(coreStorage.invocations[0],
                       .writeGeneric(value: expectModels, key: key))
    }
}
