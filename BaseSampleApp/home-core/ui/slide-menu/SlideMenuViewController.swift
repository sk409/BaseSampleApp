import UIKit

public class SlideMenuViewController: UIViewController {
    
    public var slideMenuSections = [SlideMenuSection]()
    public let slideMenuView = SlideMenuView()
    
    private var slideMenuViewLeadingConstraint: NSLayoutConstraint?
    private var slideMenuViewTrailingConstraint: NSLayoutConstraint?
    
    private let touchGuardView = UIView()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = toggle()
    }
    
    private func setupViews() {
        
        view.addSubview(touchGuardView)
        view.addSubview(slideMenuView)
        
        touchGuardView.alpha = 0
        touchGuardView.backgroundColor = .black
        touchGuardView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(onTouchGuardViewTapped))
        )
        touchGuardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            touchGuardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            touchGuardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            touchGuardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            touchGuardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        slideMenuView.backgroundColor = .white
        slideMenuView.slideMenuViewDataSource = self
        slideMenuView.slideMenuViewDelegate = self
        slideMenuView.reloadData()
        slideMenuViewLeadingConstraint = slideMenuView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor
        )
        slideMenuViewTrailingConstraint = slideMenuView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor
        )
        slideMenuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slideMenuViewTrailingConstraint!,
            slideMenuView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            slideMenuView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            slideMenuView.widthAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.widthAnchor,
                multiplier: 0.6
            ),
        ])
    }
    
    @objc
    private func toggle(completion: (() -> Void)? = nil) -> Bool {
        guard slideMenuView.state == .opened || slideMenuView.state == .closed else {
            return false
        }
        slideMenuView.state = slideMenuView.state == .opened ? .closing : .opening
        let isOpening = self.slideMenuView.state == .opening
        let alpha: CGFloat
        if isOpening {
            slideMenuViewTrailingConstraint?.isActive.toggle()
            slideMenuViewLeadingConstraint?.isActive.toggle()
            alpha = 0.8
        } else {
            slideMenuViewLeadingConstraint?.isActive.toggle()
            slideMenuViewTrailingConstraint?.isActive.toggle()
            alpha = 0
        }
        UIView.animate(
            withDuration: slideMenuView.animationDuration,
            delay: 0,
            options: .curveEaseOut,
            animations:
        {
            self.touchGuardView.alpha = alpha
            self.view.layoutIfNeeded()
        }) { finished in
            if finished {
                self.slideMenuView.state = self.slideMenuView.state == .opening
                ? .opened
                : .closed
                completion?()
            } else {
                self.slideMenuView.state = self.slideMenuView.state == .opening
                ? .closed
                : .opened
            }
        }
        return true
    }
    
    @objc
    private func onTouchGuardViewTapped() {
        _ = toggle() {
            self.dismiss(animated: false)
        }
    }
}


extension SlideMenuViewController: SlideMenuViewDelegate {
    
    public func slideMenuView(_ slideMenuView: SlideMenuView, didSelectItemAt indexPath: IndexPath) {
        let menuItem = slideMenuSections[indexPath.section].menuItems[indexPath.item]
        menuItem.onTap?()
    }
}

extension SlideMenuViewController: SlideMenuViewDataSource {
    
    public func numberOfSections(in slideMenuView: SlideMenuView) -> Int {
        return slideMenuSections.count
    }
    
    public func slideMenuView(_ slideMenuView: SlideMenuView, numberOfItemsInSection section: Int) -> Int {
        return slideMenuSections[section].menuItems.count
    }
    
    public func slideMenuView(_ slideMenuView: SlideMenuView, itemAt indexPath: IndexPath) -> SlideMenuItemView {
        let menuItem = slideMenuSections[indexPath.section].menuItems[indexPath.item]
        let menuItemView = SlideMenuItemView(
            title: menuItem.title,
            iconImage: menuItem.iconImage,
            insets: menuItem.insets
        )
        return menuItemView
    }
    
    public func slideMenuView(
        _ slideMenuView: SlideMenuView,
        headerForSectionAt section: Int
    ) -> SlideMenuSectionHeaderView? {
        let menuSection = slideMenuSections[section]
        guard menuSection.title != nil || menuSection.iconImage != nil else {
            return nil
        }
        let headerView = SlideMenuSectionHeaderView(
            title: menuSection.title,
            iconImage: menuSection.iconImage,
            collapsable: menuSection.collapsable,
            insets: menuSection.insets
        )
        headerView.titleLabel.font = .systemFont(ofSize: 18)
        headerView.titleLabel.textColor = UIColor(white: 0, alpha: 0.6)
        return headerView
    }
    
    public func slideMenuView(_ slideMenuView: SlideMenuView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    public func slideMenuView(_ slideMenuView: SlideMenuView, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}
