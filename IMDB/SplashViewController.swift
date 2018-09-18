//Pat

import UIKit

class SplashViewController: UIViewController {

    private var timer: Timer?
    private let splashTimeout: TimeInterval = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(
            withTimeInterval: splashTimeout,
            repeats: false) { [weak self] _ in
                self?.routeToSearchScreen()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func routeToSearchScreen() {
        let viewController = SearchModuleBuilder.build()
        let navigationViewController = UINavigationController(
            rootViewController: viewController
        )
        navigationViewController.modalPresentationStyle = .custom
        navigationViewController.modalTransitionStyle = .crossDissolve
        present(navigationViewController, animated: true)
    }
}

