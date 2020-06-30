import Foundation

open class LiveData<T>: NSObject {
    
    private class ObserverHolder {
        let lifecycleOwner: LifecycleOwner
        let lifecycleObserver: LifecycleObserver
        var observers = [LiveDataObserver<T>]()
        
        init(lifecycleOwner: LifecycleOwner, lifecycleObserver: LifecycleObserver) {
            self.lifecycleOwner = lifecycleOwner
            self.lifecycleObserver = lifecycleObserver
        }
    }
    
    private var observerHolders = [ObserverHolder]()
    
    fileprivate var rawValue: T {
        didSet {
            invokeObserversIfLivecycleIsValid()
        }
    }
    
    public var value: T
    
    public init(_ initialValue: T) {
        rawValue = initialValue
        value = rawValue
    }
    
    public func addObserver(lifecycleOwner: LifecycleOwner, observer: LiveDataObserver<T>) {
        if LiveData.isLifecycleValid(lifecycleOwner.lifecycle) {
            observer.invoke(value: value)
        }
        if let observerHolder = observerHolders.first(where: {$0.lifecycleOwner === lifecycleOwner}) {
            observerHolder.observers.append(observer)
        } else {
            let lifecycleObserver = LifecycleObserver()
            lifecycleObserver.onViewDidDisappear = { _ in
                self.removeAllObservers(lifecycleOwner: lifecycleOwner)
            }
            lifecycleOwner.lifecycle.addObserver(lifecycleObserver)
            observerHolders.append(ObserverHolder(lifecycleOwner: lifecycleOwner, lifecycleObserver: lifecycleObserver))
        }
    }
    
    public func removeObserver(observer: LiveDataObserver<T>) {
        for observerHolder in observerHolders {
            guard let index = observerHolder.observers.firstIndex(where: {$0 === observer}) else {
                continue
            }
            observerHolder.lifecycleOwner.lifecycle.removeObserver(observerHolder.lifecycleObserver)
            observerHolder.observers.remove(at: index)
            break
        }
    }
    
    public func removeAllObservers(lifecycleOwner: LifecycleOwner) {
        guard let index = observerHolders.firstIndex(where: {$0.lifecycleOwner === lifecycleOwner}) else {
            return
        }
        let observerHolder = observerHolders[index]
        observerHolder.lifecycleOwner.lifecycle.removeObserver(observerHolder.lifecycleObserver)
        observerHolders.remove(at: index)
    }
    
    private static func isLifecycleValid(_ lifecycle: Lifecycle) -> Bool {
        let lifecycleState = lifecycle.state
        return lifecycleState == .started || lifecycleState == .resumed
    }
    
    private func invokeObserversIfLivecycleIsValid() {
        observerHolders.forEach{ observerHolder in
            guard LiveData.isLifecycleValid(observerHolder.lifecycleOwner.lifecycle) else {
                return
            }
            observerHolder.observers.forEach { $0.invoke(value: value) }
        }
    }
}



public class MutableLiveData<T>: LiveData<T> {
    
    //============================================================
    // region LiveData<T>
    //============================================================
    
    public override var value: T {
        didSet {
            rawValue = value
        }
    }
    
    //============================================================
    // endregion LiveData<T>
    //============================================================
    
    public func postValue(value: T) {
        DispatchQueue.main.async {
            self.value = value
        }
    }
}
