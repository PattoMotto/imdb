//Pat

import Foundation

struct SearchModel: Codable {
    let title: String
    let timestamp: TimeInterval
}

protocol SearchModelStorage: ModelStorageBase {
    func read() -> SearchModel?
    func write(value: SearchModel)
}

final class SearchModelStorageImpl: SearchModelStorage {
    let key: String = "IMDB.search.model"
    let storage: CoreStorage

    init(storage: CoreStorage) {
        self.storage = storage
    }

    func read() -> SearchModel? {
        let model: SearchModel? = readCodable()
        return model
    }

    func write(value: SearchModel) {
        writeCodable(value: value)
    }
}
