//Pat

import XCTest

final class HUD: ScreenBase {

    var app: XCUIApplication

    public init(app: XCUIApplication) {
        self.app = app
    }

    var main: XCUIElement {
        return loading
    }

    private var loading: XCUIElement {
        return app.staticTexts["Loading"]
    }

    private var success: XCUIElement {
        return app.staticTexts["Success"]
    }

    private var errorEmptyList: XCUIElement {
        return app.staticTexts["Empty result"]
    }

    func expectLoading() {
        loading.waitForPresence()
        loading.waitForAbsence()
    }

    func expectSuccess() {
        success.waitForPresence()
        success.waitForAbsence()
    }

    func expectEmptyResult() {
        errorEmptyList.waitForPresence()
        errorEmptyList.waitForAbsence()
    }
}
