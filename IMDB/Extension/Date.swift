//Pat

import Foundation

extension Date {
    static func fromYYYYDDMM(value: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.date(from: value)
    }

    func toReadableDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}
