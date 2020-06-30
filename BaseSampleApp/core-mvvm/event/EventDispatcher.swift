import Foundation

public class EventDispatcher<ListenerType>: NSObject {
    
    private let queue: DispatchQueue
    private var pendingEvents = [(ListenerType) -> Void]()
    private var currentListener: ListenerType?
    
    convenience override public init() {
        self.init(queue: DispatchQueue.main)
    }
    
    public init(queue: DispatchQueue) {
        self.queue = queue
        super.init()
    }
    
    public func bind(
        lifecycleOwner: LifecycleOwner,
        listener: ListenerType
    ) {
        let lifecycleObserver = LifecycleObserver()
        lifecycleObserver.onViewDidAppear = {
            self.queue.async {
                self.currentListener = listener
                self.pendingEvents.forEach{$0(listener)}
                self.pendingEvents.removeAll()
            }
        }
        lifecycleObserver.onViewDidDisappear = { _ in
            self.currentListener = nil
            lifecycleOwner.lifecycle.removeObserver(lifecycleObserver)
        }
        lifecycleOwner.lifecycle.addObserver(lifecycleObserver)
    }
    
    public func dispatchEvent(event: @escaping (ListenerType) -> Void) {
        guard let listener = currentListener else {
            pendingEvents.append(event)
            return
        }
        queue.async {
            event(listener)
        }
    }
}
