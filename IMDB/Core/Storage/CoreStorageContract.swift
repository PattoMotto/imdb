//Pat

import Foundation

protocol CoreStorage {
    func read(key: String) -> Data?
    func write(key: String, value: Data)
    func read<T>(key: String) -> T? where T: Codable
    func write<T>(key: String, value: T) where T: Codable
    func clear(key: String)
}

protocol Store {
    func data(forKey defaultName: String) -> Data?
    func set(_ value: Any?, forKey defaultName: String)
    func string(forKey defaultName: String) -> String?
    func removeObject(forKey defaultName: String)
}

extension UserDefaults: Store { }
