//Pat

import Foundation

final class CoreStorageImpl {

    private let store: Store

    init(store: Store = UserDefaults.standard) {
        self.store = store
    }
}

extension CoreStorageImpl: CoreStorage {

    func read(key: String) -> Data? {
        return store.data(forKey: key)
    }

    func write(value: Data, key: String) {
        store.set(value, forKey: key)
    }

    func read<T>(key: String) -> T? where T: Codable {
        if T.self is String.Type {
            return store.string(forKey: key) as? T
        } else {
            guard let data = store.data(forKey: key),
                let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                    return nil
            }
            return decoded
        }
    }

    func write<T>(value: T, key: String) where T: Codable {
        if let valueString = value as? String {
            store.set(valueString, forKey: key)
        } else {
            guard let data = try? JSONEncoder().encode(value) else {
                return
            }
            store.set(data, forKey: key)
        }
    }

    func clear(key: String) {
        store.removeObject(forKey: key)
    }
}
