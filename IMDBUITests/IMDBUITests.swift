//Pat

import XCTest

class IMDBUITests: XCTestCase, UITestBase {

    var app: XCUIApplication!

    private lazy var batman = "Batman"
    private lazy var titles = ["Batman", "Super man", "Iron man",
                               "Wonder woman", "Spider man", "X men",
                               "Flash", "Doctor", "Marvel", "DC"]
    private lazy var notFoundTitle = "zzzzz"

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSearchBatmanShouldSeeMovieListWithDetails() {
        launchWithArguments(arguments: [
            UITestLaunchArgument.clearRecentSearch
            ]
        )
        search.waitForPresence()
        search.search(for: batman)
        hud.expectSuccess()
        movieList.waitForPresence()
        movieList.expectCellExistWithAllData(index: 0)
    }

    func testSearchBatmanAndScrollTo20thCell() {
        launchWithArguments(arguments: [
            UITestLaunchArgument.clearRecentSearch
            ]
        )
        search.waitForPresence()
        search.search(for: batman)
        hud.expectSuccess()
        movieList.waitForPresence()
        movieList.scrollToCell(index: 20)
        movieList.expectCellExistWithAllData(index: 20)
    }

    func testSearchWithNotExistMovieShouldShowError() {
        launchWithArguments(arguments: [
            UITestLaunchArgument.clearRecentSearch
            ]
        )
        search.waitForPresence()
        search.search(for: notFoundTitle)
        hud.expectEmptyResult()
        search.waitForPresence()
        search.expectRecentSearch(
            title: notFoundTitle,
            index: 0,
            shouldExist: false
        )
    }

    func testDifferenceSearch10TimesAndCheckRecentSearch() {
        launchWithArguments(arguments: [
            UITestLaunchArgument.clearRecentSearch
            ]
        )
        titles.forEach {
            search.search(for: $0)
            movieList.waitForPresence()
            movieList.tapBack()
        }
        search.waitForPresence()
        search.tapSearchTextField()
        titles.reversed().enumerated().forEach {
            search.expectRecentSearch(title: $1, index: $0)
        }
    }

    func testSearchFromRecentSearch() {
        launchWithArguments(arguments: [
            UITestLaunchArgument.clearRecentSearch,
            genLaunchArgument(recentSearch: [batman])
            ]
        )
        search.waitForPresence()
        search.tapSearchTextField()
        search.expectRecentSearch(title: batman, index: 0)
    }

    private func genLaunchArgument(recentSearch: [String]) -> String {
        let param = recentSearch.joined(separator: UITestLaunchArgument.separator)
        return "\(UITestLaunchArgument.mockRecentSearch)\(UITestLaunchArgument.separator)\(param)"
    }
}
