import Foundation

open class LiveData<T>: NSObject {
    
    private var observers = [LiveDataObserver<T>]()
    
    fileprivate var rawValue: T {
        didSet {
            observers.forEach{$0.invoke(value: rawValue)}
        }
    }
    
    public var value: T
    
    init(initialValue: T) {
        rawValue = initialValue
        value = rawValue
    }
    
    public func addObserver(observer: LiveDataObserver<T>) {
        observer.invoke(value: value)
        observers.append(observer)
    }
    
    public func removeObserver(
        lifecycleOwner: LifecycleOwner,
        observer: LiveDataObserver<T>
    ) {
        removeObserver(observer: observer)
    }
    
    public func removeObserver(observer: LiveDataObserver<T>) {
        guard let index = observers.firstIndex(where: {$0 === observer}) else {
            return
        }
        observers.remove(at: index)
    }
    
    public func removeAllObservers(lifecycleOwner: LifecycleOwner) {
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
