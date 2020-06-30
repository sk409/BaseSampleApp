import UIKit

extension UILabel {
    
    public func bindText(
        lifecycleOwner: LifecycleOwner,
        liveData: LiveData<String>,
        formatter: @escaping (String) -> String = {$0}
    ) {
        liveData.bind(lifecycleOwner: lifecycleOwner, view: self) { value in
            let newText = formatter(value)
            guard newText != self.text else {
                return
            }
            self.text = newText
        }
    }
}
