//Pat

import Foundation

protocol ModelStorageBase {
    var key: String { get }
    var storage: CoreStorage { get }
    func readCodable<T>() -> T? where T: Codable
    func writeCodable<T>(value: T) where T: Codable
    func clear()
}

extension ModelStorageBase {

    func readCodable<T>() -> T? where T: Codable {
        guard let model: T = storage.read(key: key) else {
            return nil
        }
        return model
    }

    func writeCodable<T>(value: T) where T: Codable {
        storage.write(key: key, value: value)
    }

    func clear() {
        storage.clear(key: key)
    }
}
