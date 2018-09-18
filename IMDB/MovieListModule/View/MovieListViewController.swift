//Pat

import Foundation
import UIKit

class MovieListViewController: UITableViewController {

    private let minRow = CGFloat(222)
    private var fetchedAll = false
    private var movies: [MovieModel] = []
    var output: MovieListViewOutput?

    override func viewDidLoad() {
        setupTableView()
        output?.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    private func setupTableView() {
        let nib = UINib(nibName: MovieTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = minRow
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? movies.count : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else {
            return MovieTableViewCell()
        }
        cell.bind(model: movies[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension MovieListViewController: MovieListViewInput {

    func showTitle(title: String) {
        self.title = title
    }

    func showMovieList(movies: [MovieModel]) {
        self.movies = movies
        tableView.reloadData()
    }

    func isFetchedAllPage() {
        fetchedAll = true
    }
}
