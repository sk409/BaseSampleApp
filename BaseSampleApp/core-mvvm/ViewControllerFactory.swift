import UIKit

public protocol ViewControllerFactory {
    
    func instantiate<T: UIViewController>(_ metatype: T.Type) -> T?
}
