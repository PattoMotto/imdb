//Pat

import Foundation
@testable import IMDB

final class StoreMock: Store, Mockable {

    var invocations = [Invocation]()

    public enum Invocation: MockInvocation {
        case data(key: String)
        case set(value: Any?, key: String)
        case string(key: String)
        case removeObject(key: String)
    }

    var mockData: Data?

    func data(forKey defaultName: String) -> Data? {
        invocations.append(.data(key: defaultName))
        return mockData
    }

    func set(_ value: Any?, forKey defaultName: String) {
        invocations.append(.set(value: value, key: defaultName))
    }

    var mockString: String?

    func string(forKey defaultName: String) -> String? {
        invocations.append(.string(key: defaultName))
        return mockString
    }

    func removeObject(forKey defaultName: String) {
        invocations.append(.removeObject(key: defaultName))
    }
}
