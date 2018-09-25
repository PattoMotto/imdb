//Pat

import Foundation
import Alamofire
@testable import IMDB

final class CoreApiMock: CoreApi, Mockable {

    var invocations = [Invocation]()

    public enum Invocation: MockInvocation {
        case get(url: URL, parameters: Parameters)
    }

    var mockResponse: DataResponse<Any>?
    func get(url: URL,
             parameters: Parameters,
             completion: @escaping (DataResponse<Any>) -> Void) {
        invocations.append(.get(url: url, parameters: parameters))
        if let response = mockResponse {
            completion(response)
        }
    }
}
