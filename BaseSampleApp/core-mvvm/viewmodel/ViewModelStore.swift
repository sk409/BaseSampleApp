import Foundation

public class ViewModelStore: NSObject {
    
    private var map = [String: ViewModel]()
    
    var keys: Dictionary<String, ViewModel>.Keys {
        map.keys
    }
    
    func put(key: String, viewModel: ViewModel) {
        guard let oldViewModel = map.updateValue(viewModel, forKey: key) else {
            return
        }
        oldViewModel.onCleared()
    }
    
    func get(key: String) -> ViewModel? {
        return map[key]
    }
    
    public func clear() {
        map.values.forEach{$0.onCleared()}
        map.removeAll()
    }
}
