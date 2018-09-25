//Pat

import Foundation
import KRProgressHUD

protocol ProgressHUD {

    func showLoading()
    func showSuccess()
    func showError(message: String)
}

extension ProgressHUD {

    func showLoading() {
        KRProgressHUD.show(withMessage: "Loading")
    }

    func showSuccess() {
        KRProgressHUD.showSuccess(withMessage: "Success")
    }

    func showError(message: String) {
        KRProgressHUD.showError(withMessage: message)
    }
}
