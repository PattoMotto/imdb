//Pat

import XCTest
@testable import IMDB

final class CoreStorageTests: XCTestCase {

    private typealias Invocation = StoreMock.Invocation
    private let key = "test.key"
    private var coreStorage: CoreStorage!
    private var store: StoreMock!

    override func setUp() {
        super.setUp()
        store = StoreMock()
        coreStorage = CoreStorageImpl(store: store)
    }

    override func tearDown() {
        store = nil
        coreStorage = nil
        super.tearDown()
    }

    func testReadData() {
        coreStorage.read(key: key)
        XCTAssertEqual(store.invocations.count, 1)
        XCTAssertEqual(store.invocations[0], Invocation.data(key: key))
    }

    func testWriteData() {
        let data = Data()
        coreStorage.write(value: data, key: key)
        XCTAssertEqual(store.invocations.count, 1)
        XCTAssertEqual(store.invocations[0], Invocation.set(value: data, key: key))
    }

    func testClear() {
        coreStorage.clear(key: key)
        XCTAssertEqual(store.invocations.count, 1)
        XCTAssertEqual(store.invocations[0], Invocation.removeObject(key: key))
    }

}
