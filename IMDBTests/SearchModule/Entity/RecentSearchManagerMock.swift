//Pat

import Foundation
@testable import IMDB

final class RecentSearchManagerMock: RecentSearchManager, Mockable {

    var invocations = [Invocation]()

    enum Invocation: MockInvocation {
        case save(title: String)
        case recentSearch
        case clear
    }

    func save(title: String) {
        invocations.append(.save(title: title))
    }

    var mockRecentSearch = [SearchModel]()

    func recentSearch() -> [SearchModel] {
        invocations.append(.recentSearch)
        return mockRecentSearch
    }

    func clear() {
        invocations.append(.clear)
    }
}
