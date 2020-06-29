import Foundation

public protocol ViewModelStoreOwner {
    
    func getViewModelStore() -> ViewModelStore
}
