//Pat

import Foundation

protocol RecentSearchManager {

    func save(title: String)
    func recentSearch() -> [SearchModel]
    func clear()
}

final class RecentSearchManagerImpl: RecentSearchManager {

    private let store: SearchModelStorage
    private var recentList: [SearchModel]
    private var recentDict: [String: Int] = [:]
    private let sizeLimit = 10

    init(store: SearchModelStorage = SearchModelStorageImpl()) {
        self.store = store
        recentList = store.read() ?? []
        generateRecentDict()
    }

    private func generateRecentDict() {
        var dict: [String: Int] = [:]
        recentList.enumerated().forEach { (index, value) in
            dict[value.title] = index
        }
        recentDict = dict
    }

    func save(title: String) {
        let newSearch = SearchModel(title: title)
        if let index = recentDict[title] {
            recentList.remove(at: index)
        } else if recentList.count == sizeLimit {
            _ = recentList.popLast()
        }
        recentList.insert(newSearch, at: 0)
        generateRecentDict()
        store.write(value: recentList)
    }

    func recentSearch() -> [SearchModel] {
        return recentList
    }

    func clear() {
        store.clear()
    }
}
