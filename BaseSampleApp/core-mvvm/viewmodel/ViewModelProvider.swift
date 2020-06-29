import Foundation

public class ViewModelProvider: NSObject {
    
    private let viewModelStore: ViewModelStore
    
    public init(viewModelStore: ViewModelStore) {
        self.viewModelStore = viewModelStore
    }
}
