import UIKit

public struct SlideMenuSection {
    public var title: String?
    public var iconImage: UIImage?
    public var menuItems: [SlideMenuItem]
    public var collapsable: Bool
    public var insets: UIEdgeInsets
    
    public init(
        title: String? = nil,
        iconImage: UIImage? = nil,
        menuItems: [SlideMenuItem] = [],
        collapsable: Bool = false,
        insets: UIEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    ) {
        self.title = title
        self.iconImage = iconImage
        self.menuItems = menuItems
        self.collapsable = collapsable
        self.insets = insets
    }
}
