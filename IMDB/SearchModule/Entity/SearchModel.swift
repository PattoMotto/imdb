//Pat

import Foundation

struct SearchModel: Codable {

    let title: String
    let timestamp: TimeInterval

    init(title: String) {
        self.title = title
        self.timestamp = Date().timeIntervalSince1970
    }

}

extension SearchModel: Comparable {

    static func < (lhs: SearchModel, rhs: SearchModel) -> Bool {
        return lhs.timestamp < rhs.timestamp &&
            lhs.title < rhs.title
    }

    static func == (lhs: SearchModel, rhs: SearchModel) -> Bool {
        return lhs.title == rhs.title
    }
}

protocol SearchModelStorage: ModelStorageBase {
    func read() -> [SearchModel]?
    func write(value: [SearchModel])
}

final class SearchModelStorageImpl: SearchModelStorage {
    let key: String = "IMDB.search.recent"
    let storage: CoreStorage

    init(storage: CoreStorage = CoreStorageImpl()) {
        self.storage = storage
    }

    func read() -> [SearchModel]? {
        let model: [SearchModel]? = readCodable()
        return model
    }

    func write(value: [SearchModel]) {
        writeCodable(value: value)
    }
}
