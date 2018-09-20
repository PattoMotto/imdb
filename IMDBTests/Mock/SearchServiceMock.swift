//Pat

import Foundation
@testable import IMDB

final class SearchServiceMock: SearchService, Mockable {

    var invocations = [Invocation]()

    public enum Invocation: MockInvocation {
        case search(title: String, page: Int)
    }

    func search(title: String, page: Int) {
        invocations.append(.search(title: title, page: page))
    }
}
