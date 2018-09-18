//Pat
import UIKit

public protocol NibLoadable: class { }

public extension NibLoadable where Self: UIView {

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}

public extension NibLoadable where Self: UITableViewCell {

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }

    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}

public extension NibLoadable where Self: UIViewController {

    static func nibNameAndBundle() -> (String, Bundle) {

        let bundle = Bundle(for: Self.self)

        // note: nib file must have the same name as the view controller class
        let nibName = (String(describing: type(of: self)) as NSString).components(separatedBy: ".").first!

        return (nibName, bundle)
    }
}


// Reference for NibLoadable
// https://github.com/AliSoftware/Reusable/blob/master/Sources/View/NibLoadable.swift
// https://gist.github.com/bizz84/dea10652cf3ba7be94ccad905fa01048
