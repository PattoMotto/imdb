//Pat

import Foundation
@testable import IMDB

final class CoreStorageMock: CoreStorage, Mockable {

    var invocations = [Invocation]()

    public enum Invocation: MockInvocation {
        case read(key: String)
        case write(value: Data, key: String)
        case readGeneric(key: String)
        case writeGeneric(value: Codable, key: String)
        case clear(key: String)
    }

    var mockData: Data?

    func read(key: String) -> Data? {
        invocations.append(.read(key: key))
        return mockData
    }

    func write(value: Data, key: String) {
        invocations.append(.write(value: value, key: key))
    }

    var mockCodable: Codable?

    func read<T>(key: String) -> T? where T: Codable {
        invocations.append(.readGeneric(key: key))
        return mockCodable as? T
    }

    func write<T>(value: T, key: String) where T: Codable {
        invocations.append(.writeGeneric(value: value, key: key))
    }

    func clear(key: String) {
        invocations.append(.clear(key: key))
    }
}
