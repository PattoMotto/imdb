//Pat

import Foundation
@testable import IMDB

final class SearchServiceOutputMock: SearchServiceOutput, Mockable {

    var invocations = [Invocation]()

    public enum Invocation: MockInvocation {
        case success(movies: [MovieModel], isFinalPage: Bool)
        case failure(message: String)
    }

    func success(movies: [MovieModel], isFinalPage: Bool) {
        invocations.append(.success(movies: movies, isFinalPage: isFinalPage))
    }

    func failure(message: String) {
        invocations.append(.failure(message: message))
    }
}
