import Foundation

extension LiveData {
    
    func bind<V: NSObject>(view: V, setter: @escaping (T) -> Void) {
        setter(value)
        let observer = LiveDataObserver<T>()
        observer.callback = {[weak view, weak self] value in
            guard let self = self else {
                return
            }
            guard view != nil else {
                self.removeObserver(observer: observer)
                return
            }
            setter(value)
        }
        addObserver(observer: observer)
    }
}
