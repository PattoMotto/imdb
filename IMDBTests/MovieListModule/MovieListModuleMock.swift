//Pat

import Foundation
@testable import IMDB

final class MovieListViewInputMock: MovieListViewInput, Mockable {

    var invocations = [Invocation]()

    enum Invocation: MockInvocation {
        case showMovieList(movies: [MovieModel])
        case showTitle(title: String)
        case showLoading
        case showSuccess
        case showError(message: String)
    }

    func showMovieList(movies: [MovieModel]) {
        invocations.append(.showMovieList(movies: movies))
    }

    func showTitle(title: String) {
        invocations.append(.showTitle(title: title))
    }

    func showLoading() {
        invocations.append(.showLoading)
    }

    func showSuccess() {
        invocations.append(.showSuccess)
    }

    func showError(message: String) {
        invocations.append(.showError(message: message))
    }
}

final class MovieListViewOutputMock: MovieListViewOutput, Mockable {

    var invocations = [Invocation]()

    enum Invocation: MockInvocation {
        case viewIsReady
        case didScrollToBottom
    }

    func viewIsReady() {
        invocations.append(.viewIsReady)
    }

    func didScrollToBottom() {
        invocations.append(.didScrollToBottom)
    }
}

final class MovieListInteractorInputMock: MovieListInteractorInput, Mockable {

    var invocations = [Invocation]()

    enum Invocation: MockInvocation {
        case search(title: String, page: Int)
    }

    func search(title: String, page: Int) {
        invocations.append(.search(title: title, page: page))
    }
}

final class MovieListInteractorOutputMock: MovieListInteractorOutput, Mockable {

    var invocations = [Invocation]()

    enum Invocation: MockInvocation {
        case success(movies: [MovieModel])
        case failure(message: String)
        case isFetchedAllPage
    }

    func success(movies: [MovieModel]) {
        invocations.append(.success(movies: movies))
    }

    func failure(message: String) {
        invocations.append(.failure(message: message))
    }

    func isFetchedAllPage() {
        invocations.append(.isFetchedAllPage)
    }
}
