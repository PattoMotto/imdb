//Pat

import XCTest
@testable import IMDB

final class SearchViewControllerTests: XCTestCase {

    private let title = "Test Title"
    private var viewController: SearchViewController!
    private var output: SearchViewOutputMock!
    private let textField = UITextField()
    override func setUp() {
        super.setUp()
        output = SearchViewOutputMock()
        viewController = SearchViewController()
        viewController.output = output
        textField.text = title
    }

    override func tearDown() {
        output = nil
        viewController = nil
        super.tearDown()
    }

    func testViewIsReady() {
        _ = viewController.view
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], .viewIsReady)
    }

    func testSearchButtonDidTap() {
        _ = viewController.view
        viewController.searchTextField.text = title
        viewController.searchButtonTouchUpInside(UIButton())
        XCTAssertEqual(output.invocations.count, 2)
        XCTAssertEqual(output.invocations[1], .searchButtonDidTap(title: title))
    }

    func testSearchTextDidTap() {
        _ = viewController.textFieldShouldBeginEditing(textField)
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], .searchTextDidTap)
    }

    func testRecentSearchDidTap() {
        let tableView = UITableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let recentSearch = [SearchModel(title: title)]
        _ = viewController.view
        viewController.show(recentSearch: recentSearch)
        viewController.tableView(tableView, didSelectRowAt: indexPath)
        XCTAssertEqual(output.invocations.count, 2)
        XCTAssertEqual(output.invocations[1], .recentSearchDidTap(title: title))
    }
}
