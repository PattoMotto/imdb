//Pat

import UIKit

class SplashViewController: UIViewController {

    private var timer: Timer?
    private let splashTimeout: TimeInterval = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(
            timeInterval: splashTimeout,
            target: self,
            selector: #selector(routeToSearchScreen),
            userInfo: nil,
            repeats: false
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc private func routeToSearchScreen() {
        let viewController = SearchModuleBuilder.build()
        let navigationViewController = UINavigationController(
            rootViewController: viewController
        )
        navigationViewController.modalPresentationStyle = .custom
        navigationViewController.modalTransitionStyle = .crossDissolve
        present(navigationViewController, animated: true)
    }
}
