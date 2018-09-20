//Pat

import Foundation

protocol CoreStorage {
    @discardableResult func read(key: String) -> Data?
    func write(value: Data, key: String)
    @discardableResult func read<T>(key: String) -> T? where T: Codable
    func write<T>(value: T, key: String) where T: Codable
    func clear(key: String)
}

protocol Store {
    func data(forKey defaultName: String) -> Data?
    func set(_ value: Any?, forKey defaultName: String)
    func string(forKey defaultName: String) -> String?
    func removeObject(forKey defaultName: String)
}

extension UserDefaults: Store { }
