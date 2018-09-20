//Pat

import Foundation
@testable import IMDB

final class SearchViewInputMock: SearchViewInput, Mockable {

    var invocations = [Invocation]()

    public enum Invocation: MockInvocation {
        case show(recentSearch: [SearchModel])
        case showNormalLayout
        case showFocusedLayout
        case showLoading
        case showSuccess
        case showError(message: String)
    }

    func show(recentSearch: [SearchModel]) {
        invocations.append(.show(recentSearch: recentSearch))
    }

    func showNormalLayout() {
        invocations.append(.showNormalLayout)
    }

    func showFocusedLayout() {
        invocations.append(.showFocusedLayout)
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

final class SearchViewOutputMock: SearchViewOutput, Mockable {

    var invocations = [Invocation]()

    public enum Invocation: MockInvocation {
        case viewIsReady
        case searchTextDidTap
        case searchButtonDidTap(title: String)
        case recentSearchDidTap(title: String)
    }

    func viewIsReady() {
        invocations.append(.viewIsReady)
    }

    func searchTextDidTap() {
        invocations.append(.searchTextDidTap)
    }

    func searchButtonDidTap(title: String) {
        invocations.append(.searchButtonDidTap(title: title))
    }

    func recentSearchDidTap(title: String) {
        invocations.append(.recentSearchDidTap(title: title))
    }
}

final class SearchInteractorInputMock: SearchInteractorInput, Mockable {

    var invocations = [Invocation]()

    public enum Invocation: MockInvocation {
        case search(title: String)
        case fetchRecentSearch
        case saveRecentSearch(title: String)
    }

    func search(title: String) {
        invocations.append(.search(title: title))
    }

    func fetchRecentSearch() {
        invocations.append(.fetchRecentSearch)
    }

    func saveRecentSearch(title: String) {
        invocations.append(.saveRecentSearch(title: title))
    }
}

final class SearchInteractorOutputMock: SearchInteractorOutput, Mockable {

    var invocations = [Invocation]()

    public enum Invocation: MockInvocation {
        case success(movies: [MovieModel], isFinalPage: Bool)
        case failure(message: String)
        case successRecentSearch([SearchModel])
    }

    func success(movies: [MovieModel], isFinalPage: Bool) {
        invocations.append(.success(movies: movies, isFinalPage: isFinalPage))
    }

    func failure(message: String) {
        invocations.append(.failure(message: message))
    }

    func success(recentSearch: [SearchModel]) {
        invocations.append(.successRecentSearch(recentSearch))
    }
}

final class SearchRouterInputMock: SearchRouterInput, Mockable {

    var invocations = [Invocation]()

    public enum Invocation: MockInvocation {
        case routeToMovieList(searchTitle: String,
                              movies: [MovieModel],
                              isFinalPage: Bool)
    }

    func routeToMovieList(searchTitle: String,
                          movies: [MovieModel],
                          isFinalPage: Bool) {
        invocations.append(.routeToMovieList(
            searchTitle: searchTitle,
            movies: movies,
            isFinalPage: isFinalPage
            ))
    }
}
