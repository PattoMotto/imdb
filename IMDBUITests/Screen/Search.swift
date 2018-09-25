//Pat

import XCTest

final class Search: ScreenBase {

    var app: XCUIApplication

    public init(app: XCUIApplication) {
        self.app = app
    }

    var main: XCUIElement {
        return query(
            type: SearchViewIdentifier.main.elementType,
            identifier: SearchViewIdentifier.main.rawValue
        )
    }

    private var searchTextField: XCUIElement {
        return query(
            type: SearchViewIdentifier.searchTextField.elementType,
            identifier: SearchViewIdentifier.searchTextField.rawValue
        )
    }

    private var searchButton: XCUIElement {
        return query(
            type: SearchViewIdentifier.searchButton.elementType,
            identifier: SearchViewIdentifier.searchButton.rawValue
        )
    }

    private var recentSearchTableView: XCUIElement {
        return query(
            type: SearchViewIdentifier.recentSearchTableView.elementType,
            identifier: SearchViewIdentifier.recentSearchTableView.rawValue
        )
    }

    private func recentSearchCell(index: Int) -> XCUIElement {
        let viewIdentifier = SearchViewIdentifier.recentSearchCell(index: index)
        return query(
            type: viewIdentifier.elementType,
            identifier: viewIdentifier.rawValue,
            element: recentSearchTableView
        )
    }

    func search(for title: String) {
        searchTextField.tap()
        let clearButton = searchTextField.buttons["Clear text"]
        if clearButton.exists {
            clearButton.tap()
        }
        searchTextField.typeText(title)
        searchButton.tap()
    }

    func tapSearchTextField() {
        searchTextField.tap()
    }

    func expectRecentSearch(title: String, index: Int, shouldExist: Bool = true) {
        if recentSearchCell(index: index).exists &&
            !recentSearchCell(index: index).visible() {
            scrollToCell(index: index)
        }
        if recentSearchCell(index: index).visible() {
            XCTAssertEqual(recentSearchCell(index: index).label == title, shouldExist)
        } else {
            XCTAssertFalse(shouldExist)
        }
    }

    func scrollToCell(index: Int) {
        recentSearchTableView.scrollToElement(element: recentSearchCell(index: index))
    }
}

extension SearchViewIdentifier: UITestElementQuery {
    var elementType: XCUIElement.ElementType {
        switch self {
        case .main:
            return .other
        case .searchButton:
            return .button
        case .recentSearchTableView:
            return .table
        case .recentSearchCell(index: _):
            return .cell
        case .searchTextField:
            return .textField
        }
    }
}
