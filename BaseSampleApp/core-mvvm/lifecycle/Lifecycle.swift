import Foundation

//public protocol Lifecycle: NSObjectProtocol {
//    func addObserver(observer: LifecycleObserver)
//    func removeObserver(observer: LifecycleObserver)
//}

public class Lifecycle: NSObject {
    
    public enum State {
        case initialized
        case created
        case started
        case resumed
        case destroyed
    }

    weak var owner: LifecycleOwner?
    private(set) public var state = State.initialized
    private var observers = [LifecycleObserver]()

    open func onLoadView() {
        observers.forEach{$0.onLoadView?()}
    }

    open func onViewDidLoad() {
        state = .created
        observers.forEach{$0.onViewDidLoad?()}
    }

    open func onViewWillAppear() {
        observers.forEach{$0.onViewWillAppear?()}
    }

    open func onViewWillLayoutSubviews() {
        observers.forEach{$0.onViewWillLayoutSubviews?()}
    }

    open func onViewDidLayoutSubviews() {
        observers.forEach{$0.onViewDidLayoutSubviews?()}
    }

    open func onViewDidAppear() {
        state = .resumed
        observers.forEach{$0.onViewDidAppear?()}
    }

    open func onViewWillDisappear() {
        observers.forEach{$0.onViewWillDisappear?()}
    }

    open func onViewDidDisappear() {
        state = .destroyed
        observers.forEach{$0.onViewDidDisappear?(owner)}
    }

    public func addObserver(_ observer: LifecycleObserver) {
        observers.append(observer)
    }

    public func removeObserver(_ observer: LifecycleObserver) {
        guard let index = observers.firstIndex(where: { $0 === observer }) else {
            return
        }
        observers.remove(at: index)
    }
}
