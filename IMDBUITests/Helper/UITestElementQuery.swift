//Pat

import Foundation
import XCTest

protocol UITestElementQuery: ViewIdentifier {

    var elementType: XCUIElement.ElementType { get }
}
