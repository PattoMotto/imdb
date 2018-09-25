//Pat

import Foundation

protocol ViewIdentifier: RawRepresentable {}

extension ViewIdentifier {

    public typealias RawValue = String

    public init?(rawValue: Self.RawValue) {
        return nil
    }

    public var rawValue: String {

        return "\(type(of: self)).\(self)"
    }
}
