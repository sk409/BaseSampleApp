import Foundation

extension LiveData {
    
    func bind<V: NSObject>(lifecycleOwner: LifecycleOwner, view: V, setter: @escaping (T) -> Void) {
        setter(value)
        let observer = LiveDataObserver<T>()
        observer.callback = {[weak self, weak view, weak observer] value in
            guard let self = self, let observer = observer else {
                return
            }
            guard view != nil else {
                self.removeObserver(observer: observer)
                return
            }
            setter(value)
        }
        addObserver(lifecycleOwner: lifecycleOwner, observer: observer)
    }
}
