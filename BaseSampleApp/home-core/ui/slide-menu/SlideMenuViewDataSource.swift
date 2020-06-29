import UIKit

public protocol SlideMenuViewDataSource: NSObjectProtocol {
    func numberOfSections(
        in slideMenuView: SlideMenuView
    ) -> Int
    
    func slideMenuView(
        _ slideMenuView: SlideMenuView,
        numberOfItemsInSection section: Int
    ) -> Int
    
    func slideMenuView(
        _ slideMenuView: SlideMenuView,
        itemAt indexPath: IndexPath
    ) -> SlideMenuItemView
    
    func slideMenuView(
        _ slideMenuView: SlideMenuView,
        headerForSectionAt section: Int
    ) -> SlideMenuSectionHeaderView?

    func slideMenuView(
        _ slideMenuView: SlideMenuView,
        dividerForSectionAt section: Int
    ) -> UIView?
    
    func slideMenuView(
        _ slideMenuView: SlideMenuView,
        dividerForItemAt indexPath: IndexPath
    ) -> UIView?
    
    func slideMenuView(
        _ slideMenuView: SlideMenuView,
        heightForHeaderInSection section: Int
    ) -> CGFloat
    
    func slideMenuView(
        _ slideMenuView: SlideMenuView,
        heightForItemAt indexPath: IndexPath
    ) -> CGFloat
}

extension SlideMenuViewDataSource {
    
    func numberOfSections(in slideMenuView: SlideMenuView) -> Int {
        return 1
    }
    
    func slideMenuView(
        _ slideMenuView: SlideMenuView,
        headerForSectionAt section: Int
    ) -> SlideMenuSectionHeaderView? {
        return nil
    }

    public func slideMenuView(
        _ slideMenuView: SlideMenuView,
        dividerForSectionAt section: Int
    ) -> UIView? {
        guard section != 0 else {
            return nil
        }
        let dividerView = UIView()
        dividerView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.heightAnchor.constraint(
            equalToConstant: 1
        ).isActive = true
        return dividerView
    }
    
    public func slideMenuView(
        _ slideMenuView: SlideMenuView,
        dividerForItemAt indexPath: IndexPath
    ) -> UIView? {
        return nil
    }
    
    func slideMenuView(
        _ slideMenuView: SlideMenuView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 52
    }
    
    func slideMenuView(
        _ slideMenuView: SlideMenuView,
        heightForItemAt indexPath: IndexPath
    ) -> CGFloat {
        return 52
    }
}
