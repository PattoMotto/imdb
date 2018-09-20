//Pat

import Foundation
import UIKit

final class ViewControllerMock: UIViewController, Mockable {

    var invocations = [Invocation]()

    public enum Invocation: MockInvocation {
        case presentViewController
    }

    var mockNavigationController = NavigationControllerMock()

    override var navigationController: UINavigationController? {
        return mockNavigationController
    }

    override func present(_ viewControllerToPresent: UIViewController,
                          animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        invocations.append(.presentViewController)
    }
}
