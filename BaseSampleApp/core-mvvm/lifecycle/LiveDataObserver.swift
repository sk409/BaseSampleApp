import Foundation

public class LiveDataObserver<T> {
    
    public var callback: ((T) -> Void)?
    
    public func invoke(value: T) {
        callback?(value)
    }
}
