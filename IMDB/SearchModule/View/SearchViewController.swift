//Pat

import Foundation
import UIKit
import Typist

final class SearchViewController: UIViewController {
    let animationDuration = 0.4
    let defaultMargin = CGFloat(8)
    let keyboard = Typist()
    var output: SearchViewOutput?
    private var recentSearch: [SearchModel] = []
    private let selectedBackgroundView = UIView()
    private var movieTitle: String {
        return searchTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
    }

    @IBOutlet weak var searchTextTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTextCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var recentSearchTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var keyboardDisableView: UIView!
    @IBAction func searchButtonTouchUpInside(_ sender: UIButton) {
        guard movieTitle.count > 0 else { return }
        output?.searchButtonDidTap(title: movieTitle)
    }

    override func viewDidLoad() {
        searchTextField.delegate = self
        recentSearchTableView.alpha = 0
        recentSearchTableView.layer.cornerRadius = 5
        recentSearchTableView.clipsToBounds = true
        searchButton.isEnabled = false
        selectedBackgroundView.backgroundColor = .white
        setupKeyboardObserver()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDisableViewDidTap))
        keyboardDisableView.addGestureRecognizer(tapRecognizer)
        output?.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    @objc func keyboardDisableViewDidTap() {
        showNormalLayout()
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
                strongSelf.tableViewBottomConstraint.constant = height + strongSelf.defaultMargin
                strongSelf.animate()
            }.on(event: .willHide) { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.tableViewBottomConstraint.constant = strongSelf.defaultMargin
                strongSelf.animate()
            }.start()
    }

    private func fadeInRecentSearchIfNeeded() {
        if recentSearch.count > 0 {
            animate { [weak self] in
                self?.recentSearchTableView.alpha = 1
            }
        }
    }

    private func updateSearchTextFieldIfNeeded() {
        if let mostRecentSearch = recentSearch.first {
            searchTextField.text = mostRecentSearch.title
            updateSearchButtonState()
        }
    }

    private var shouldEnableSearchButton: Bool {
        return movieTitle.count > 0
    }

    private func updateSearchButtonState() {
        searchButton.isEnabled = shouldEnableSearchButton
    }
}

extension SearchViewController: ProgressHUD { }

extension SearchViewController: SearchViewInput {

    func show(recentSearch: [SearchModel]) {
        self.recentSearch = recentSearch
        recentSearchTableView.reloadData()
        updateSearchTextFieldIfNeeded()
    }

    func showNormalLayout() {
        searchTextField.resignFirstResponder()
        updateSearchButtonState()
        searchTextTopConstraint.priority = .defaultLow
        searchTextCenterConstraint.priority = .defaultHigh
        animate { [weak self] in
            self?.recentSearchTableView.alpha = 0
        }
    }

    func showFocusedLayout() {
        updateSearchButtonState()
        searchTextTopConstraint.priority = .defaultHigh
        searchTextCenterConstraint.priority = .defaultLow
        fadeInRecentSearchIfNeeded()
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

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchButton.isEnabled = false
        return true
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        updateSearchButtonState()
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
        return recentSearch.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ??
            UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = recentSearch[indexPath.row].title
        cell.backgroundColor = .clear
        cell.selectedBackgroundView = selectedBackgroundView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.recentSearchDidTap(title: recentSearch[indexPath.row].title)
    }

}
