import Foundation

//public protocol LifecycleOwner: NSObjectProtocol {
//}

public protocol LifecycleOwner: NSObjectProtocol {

    var lifecycle: Lifecycle { get }
}
