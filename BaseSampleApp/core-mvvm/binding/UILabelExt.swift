import UIKit

extension UILabel {
    
    public func bindText(
        liveData: LiveData<String>,
        formatter: @escaping (String) -> String = {$0}
    ) {
        liveData.bind(view: self) { value in
            let newText = formatter(value)
            guard newText != self.text else {
                return
            }
            self.text = newText
        }
    }
}
