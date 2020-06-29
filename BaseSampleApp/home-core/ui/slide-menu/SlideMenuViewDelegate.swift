import UIKit

public protocol SlideMenuViewDelegate: NSObjectProtocol {
    
    func slideMenuView(
        _ slideMenuView: SlideMenuView,
        didSelectItemAt indexPath: IndexPath
    )
}

extension SlideMenuViewDelegate {
}
