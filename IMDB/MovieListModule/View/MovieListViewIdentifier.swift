//Pat

import Foundation

enum MovieListViewIdentifier: ViewIdentifier {

    case main
    case cell(index: Int)
    case movieTitle(index: Int)
    case moviePoster(index: Int)
    case movieReleaseDate(index: Int)
    case movieOverView(index: Int)
}
