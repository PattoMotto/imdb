//Pat

import XCTest

protocol UITestBase: class {

    var app: XCUIApplication! { get }
    func launch()
    func launchWithArguments(arguments: [String])
}

extension UITestBase {

    func launch() {
        app.launch()
    }

    func launchWithArguments(arguments: [String]) {
        app.launchArguments = arguments
        app.launch()
    }
}

extension UITestBase {

    var search: Search {
        return Search(app: app)
    }

    var movieList: MovieList {
        return MovieList(app: app)
    }

    var hud: HUD {
        return HUD(app: app)
    }
}
