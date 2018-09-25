//Pat

import XCTest

final class MovieList: ScreenBase {

    var app: XCUIApplication

    public init(app: XCUIApplication) {
        self.app = app
    }

    var main: XCUIElement {
        return query(
            type: MovieListViewIdentifier.main.elementType,
            identifier: MovieListViewIdentifier.main.rawValue
        )
    }

    private var backButton: XCUIElement {
        return app.navigationBars.buttons.element(boundBy: 0)
    }

    private func cell(index: Int) -> XCUIElement {
        let viewIdentifier = MovieListViewIdentifier.cell(index: index)
        return query(
            type: viewIdentifier.elementType,
            identifier: viewIdentifier.rawValue,
            element: main
        )
    }

    private func movieTitle(index: Int) -> XCUIElement {
        let viewIdentifier = MovieListViewIdentifier.movieTitle
        return query(
            type: viewIdentifier.elementType,
            identifier: viewIdentifier.rawValue,
            element: cell(index: index)
        )
    }

    private func movieOverView(index: Int) -> XCUIElement {
        let viewIdentifier = MovieListViewIdentifier.movieOverView
        return query(
            type: viewIdentifier.elementType,
            identifier: viewIdentifier.rawValue,
            element: cell(index: index)
        )
    }

    private func movieReleaseDate(index: Int) -> XCUIElement {
        let viewIdentifier = MovieListViewIdentifier.movieReleaseDate
        return query(
            type: viewIdentifier.elementType,
            identifier: viewIdentifier.rawValue,
            element: cell(index: index)
        )
    }

    private func moviePoster(index: Int) -> XCUIElement {
        let viewIdentifier = MovieListViewIdentifier.moviePoster
        return query(
            type: viewIdentifier.elementType,
            identifier: viewIdentifier.rawValue,
            element: cell(index: index)
        )
    }

    func expectCellExistWithAllData(index: Int) {
        let nCell = cell(index: index)
        nCell.waitForPresence()
        XCTAssertTrue(movieTitle(index: index).exists)
        XCTAssertTrue(movieOverView(index: index).exists)
        XCTAssertTrue(movieReleaseDate(index: index).exists)
        XCTAssertTrue(moviePoster(index: index).exists)
    }

    func scrollToCell(index: Int) {
        main.scrollToElement(element: cell(index: index))
    }

    func tapBack() {
        backButton.tap()
    }
}

extension MovieListViewIdentifier: UITestElementQuery {

    var elementType: XCUIElement.ElementType {
        switch self {
        case .main:
            return .table
        case .cell(index: _):
            return .cell
        case .movieTitle,
             .movieOverView,
             .movieReleaseDate:
            return .staticText
        case .moviePoster:
            return .image
        }
    }
}
