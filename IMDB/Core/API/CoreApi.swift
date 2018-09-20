//Pat

import Foundation
import Alamofire

protocol CoreApi {

    func get(url: URL,
             parameters: Parameters,
             completion: @escaping (DataResponse<Any>) -> Void)
}

final class CoreApiImpl: CoreApi {

    private struct CoreKey {
        static let apiKey = "api_key"
    }
    private let timeout = 10.0
    private let sessionManager: SessionManager

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
//        disable cache for debugging
        configuration.urlCache = nil
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }

    func get(url: URL,
             parameters: Parameters,
             completion: @escaping (DataResponse<Any>) -> Void) {
        sessionManager.request(
            url,
            method: .get,
            parameters: appendApiKey(parameters)
            ).responseJSON(completionHandler: completion)
    }

    private func appendApiKey(_ parameters: Parameters) -> Parameters {
        var newParameters = parameters
        newParameters[CoreKey.apiKey] = CoreConstant.movieDbApiKey
        return newParameters
    }
}
