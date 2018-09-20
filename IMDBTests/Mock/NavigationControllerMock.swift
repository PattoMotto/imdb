//Pat

import Foundation
import UIKit

final class NavigationControllerMock: UINavigationController, Mockable {

    var invocations = [Invocation]()

    public enum Invocation: MockInvocation {
        case pushViewController
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        invocations.append(.pushViewController)
    }
}
