

public protocol ViewModelFactory {
        
    func create<T: ViewModel>(_ metatype: T.Type) -> T?

}
