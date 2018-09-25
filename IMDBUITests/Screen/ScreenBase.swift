//Pat

import XCTest

struct UITestTimeOut {

    private init() {}
    static let short: TimeInterval = 1
    static let long: TimeInterval = 10
}

protocol ScreenBase {

    var app: XCUIApplication { get }
    var main: XCUIElement { get }
    func waitForPresence(duration: TimeInterval)
    func waitForAbsence(duration: TimeInterval)
    func query(type: XCUIElement.ElementType,
               identifier: String,
               element: XCUIElement?) -> XCUIElement
}
extension XCUIElement {

    func waitForPresence(duration: TimeInterval = UITestTimeOut.long) {
        if !exists {
            guard self.waitForExistence(timeout: duration) else {
                return XCTFail("\(self) waitForPresent timeout")
            }
        }
    }
    func waitForAbsence(duration: TimeInterval = UITestTimeOut.long) {
        guard !exists else { return }
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        let result = XCTWaiter().wait(for: [expectation], timeout: duration)
        XCTAssertTrue(result == .completed)
    }
}
extension ScreenBase {

    func waitForPresence(
        duration: TimeInterval = UITestTimeOut.long) {
        main.waitForPresence()
    }

    func waitForAbsence(
        duration: TimeInterval = UITestTimeOut.long) {
        main.waitForAbsence()
    }

    func query(type: XCUIElement.ElementType,
               identifier: String,
               element: XCUIElement? = nil) -> XCUIElement {
        switch type {
        case .staticText:
            return element?.staticTexts[identifier] ?? app.staticTexts[identifier]
        case .button:
            return element?.buttons[identifier] ?? app.buttons[identifier]
        case .textField:
            return element?.textFields[identifier] ?? app.textFields[identifier]
        case .image:
            return element?.images[identifier] ?? app.images[identifier]
        case .table:
            return element?.tables[identifier] ?? app.tables[identifier]
        case .cell:
            return element?.cells[identifier] ?? app.cells[identifier]
        case .other:
            return element?.otherElements[identifier] ?? app.otherElements[identifier]
        default:
            return element?.otherElements[identifier] ?? app.otherElements[identifier]
        }
    }
}
