//Pat

import Foundation
import UIKit
import Typist
import KRProgressHUD

final class SearchViewController: UIViewController {
    let animationDuration = 0.3
    let defaultMargin = CGFloat(8)
    let keyboard = Typist()
    var output: SearchViewOutput?
    @IBOutlet weak var searchTextTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTextCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var lastSearchTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func searchButtonTouchUpInside(_ sender: UIButton) {
        output?.searchButtonDidTap()
    }

    override func viewDidLoad() {
        searchTextField.delegate = self
        lastSearchTableView.alpha = 0
        searchButton.isEnabled = false
        setupKeyboardObserver()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    private func animate(closure: (() -> Void)? = nil) {
        UIView.animate(withDuration: animationDuration) { [weak self] in
            closure?()
            self?.view.layoutIfNeeded()
        }
    }

    private func setupKeyboardObserver() {
        keyboard
            .on(event: .willChangeFrame) { [weak self] options in
            let height = options.endFrame.height
                guard let strongSelf = self else { return }
                strongSelf.tableViewBottomConstraint.constant = height
                strongSelf.animate()
            }.on(event: .willHide) { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.tableViewBottomConstraint.constant = strongSelf.defaultMargin
                strongSelf.animate()
            }.start()
    }
}

extension SearchViewController: SearchViewInput {
    func showLastSearch() {

    }

    func showNormalLayout() {
        searchTextField.resignFirstResponder()
        searchButton.isEnabled = false
        searchTextTopConstraint.priority = .defaultLow
        searchTextCenterConstraint.priority = .defaultHigh
        animate { [weak self] in
            self?.lastSearchTableView.alpha = 0
        }
    }

    func showFocusedLayout() {
        searchButton.isEnabled = true
        searchTextTopConstraint.priority = .defaultHigh
        searchTextCenterConstraint.priority = .defaultLow
        animate { [weak self] in
            self?.lastSearchTableView.alpha = 1
        }
    }

    func showLoading() {
        KRProgressHUD.show(withMessage: "Loading...")
    }

    func showSuccess() {
        KRProgressHUD.showSuccess()
    }

    func showError() {
        KRProgressHUD.showError()
    }
}

extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        output?.searchTextDidTap()
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        showNormalLayout()
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        showNormalLayout()
        return true
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "Cell \(indexPath.row)"
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
