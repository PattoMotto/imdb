//Pat

import Foundation
@testable import IMDB

final class SearchModelStorageMock: SearchModelStorage, Mockable {

    let key = "IMDB.search.recent"

    let storage: CoreStorage = CoreStorageMock()

    var invocations = [Invocation]()

    enum Invocation: MockInvocation {
        case read
        case write
    }

    var mockSearchModels: [SearchModel]?
    func read() -> [SearchModel]? {
        invocations.append(.read)
        return mockSearchModels
    }

    func write(value: [SearchModel]) {
        invocations.append(.write)
    }

}
