//Pat

import XCTest

extension XCUIElement {

    func scrollToElement(element: XCUIElement) {
        var retry = 20
        while !element.visible() && retry > 0 {
            let childFrame = element.frame
            if !childFrame.isEmpty && childFrame.minY > 0 && childFrame.minY < 1000 {
                gentleSwipeUp()
            } else {
                swipeUp()
            }
            retry-=1
        }
    }

    func gentleSwipeUp() {
        let pressDuration: TimeInterval = 0.05
        let startPosition = CGVector(dx: 0.5, dy: 0.5)
        let stopPosition = CGVector(dx: 0.5, dy: 0.25)

        let start = coordinate(withNormalizedOffset: startPosition)
        let stop = coordinate(withNormalizedOffset: stopPosition)

        start.press(forDuration: pressDuration, thenDragTo: stop)
    }

    func visible() -> Bool {
        guard exists && !frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
    }

    func waitForHittable(duration: TimeInterval = UITestTimeOut.long) {
        let predicate = NSPredicate(format: "isHittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        let result = XCTWaiter().wait(for: [expectation], timeout: duration)
        XCTAssertTrue(result == .completed)
    }
}
