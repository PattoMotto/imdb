//Pat

import Foundation

struct MovieModel: Codable {

    let title: String
    let posterPath: String
    let releaseDate: Date
    let overview: String
}

extension MovieModel: Equatable {

    static func == (lhs: MovieModel, rhs: MovieModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.releaseDate == rhs.releaseDate &&
            lhs.posterPath == rhs.posterPath &&
            lhs.overview == rhs.overview
    }
}

func posterUrl(width: Double, path: String) -> URL? {

    let fractionOfTen = pow(10, log10(width))
    let ceilingWidth = Int(((width / fractionOfTen) + 1) * fractionOfTen)
    return URL(string: "https://image.tmdb.org/t/p/w\(ceilingWidth)\(path)")
}

protocol MovieModelMapper {

    func fromJson(json: [String: Any]) -> MovieModel?
    func fromJsonArray(jsonArray: [[String: Any]]) -> [MovieModel]
}

final class MovieModelMapperImpl: MovieModelMapper {

    private struct ResultListKey {
        static let title = "title"
        static let posterPath = "poster_path"
        static let releaseDate = "release_date"
        static let overview = "overview"
    }

    func fromJson(json: [String: Any]) -> MovieModel? {
        let title: String = json[ResultListKey.title] as? String ?? ""
        let posterPath: String = json[ResultListKey.posterPath] as? String ?? ""
        let overview: String = json[ResultListKey.overview] as? String ?? ""
        guard let releaseDateString = json[ResultListKey.releaseDate] as? String,
            let releaseDate = Date.fromYYYYDDMM(value: releaseDateString) else {
                return nil
        }
        return MovieModel(
            title: title,
            posterPath: posterPath,
            releaseDate: releaseDate,
            overview: overview
        )
    }

    func fromJsonArray(jsonArray: [[String: Any]]) -> [MovieModel] {
        return jsonArray.flatMap { fromJson(json: $0) }
    }
}
