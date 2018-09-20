//Pat

import Foundation

protocol MockInvocation: RawRepresentable, Hashable { }

extension MockInvocation {
    init?(rawValue: Self.RawValue) {
        return nil
    }

    var rawValue: String {
        return "\(self)"
    }

    var hashValue: Int {
        return rawValue.hashValue
    }
}

func == <T: MockInvocation> (lhs: T?, rhs: T?) -> Bool {
    return lhs?.hashValue == rhs?.hashValue
}

protocol Mockable {
    associatedtype Invocation
    var invocations: [Invocation] { get }
}
