//Pat

import Foundation
import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MovieTableViewCell"

    @IBOutlet weak var titleTextView: UILabel!
    @IBOutlet weak var releaseDateTextView: UILabel!
    @IBOutlet weak var overviewTextView: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    func bind(model: MovieModel) {
        titleTextView.text = model.title
        releaseDateTextView.text = model.releaseDate.toReadableDate()
        overviewTextView.text = model.overview

        guard let resource = posterUrl(
            width: Double(posterImageView.frame.width),
            path: model.posterPath
            ) else { return }
        posterImageView.kf.setImage(with: resource)
    }
}
