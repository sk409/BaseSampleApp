import Foundation

open class LifecycleObserver: NSObject {

    public override init() {
        super.init()
    }

    open var onLoadView: (() -> Void)?

    open var onViewDidLoad: (() -> Void)?

    open var onViewWillAppear: (() -> Void)?

    open var onViewWillLayoutSubviews: (() -> Void)?

    open var onViewDidLayoutSubviews: (() -> Void)?

    open var onViewDidAppear: (() -> Void)?

    open var onViewWillDisappear: (() -> Void)?

    open var onViewDidDisappear: ((LifecycleOwner?) -> Void)?
}

//public protocol LifecycleObserver: NSObjectProtocol {
//}
