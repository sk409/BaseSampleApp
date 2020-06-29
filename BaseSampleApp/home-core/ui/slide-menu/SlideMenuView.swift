import UIKit

open class SlideMenuView: UIScrollView {
    
    public enum State {
        case opening
        case opened
        case closing
        case closed
    }
    
    open weak var slideMenuViewDataSource: SlideMenuViewDataSource?
    open weak var slideMenuViewDelegate: SlideMenuViewDelegate?
    
    open var state = State.closed
    open var animationDuration: TimeInterval = 0.25
    
    private let menuItemsStackView = UIStackView()
    
    public init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func reloadData() {
        menuItemsStackView.arrangedSubviews.forEach { arrangedSubview in
            menuItemsStackView.removeArrangedSubview(arrangedSubview)
            arrangedSubview.removeFromSuperview()
        }
        loadData()
    }
    
    private func setupViews() {
        addSubview(menuItemsStackView)
        menuItemsStackView.axis = .vertical
        menuItemsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuItemsStackView.leadingAnchor.constraint(
                equalTo: contentLayoutGuide.leadingAnchor
            ),
            menuItemsStackView.topAnchor.constraint(
                equalTo: contentLayoutGuide.topAnchor
            ),
            menuItemsStackView.bottomAnchor.constraint(
                equalTo: contentLayoutGuide.bottomAnchor
            ),
            menuItemsStackView.widthAnchor.constraint(
                equalTo: frameLayoutGuide.widthAnchor
            ),
        ])
    }
    
    private func loadData() {
        guard let slideMenuViewDataSource = slideMenuViewDataSource else {
            return
        }
        let numberOfSections = slideMenuViewDataSource.numberOfSections(in: self)
        for section in 0..<numberOfSections {
            if let dividerForSection = slideMenuViewDataSource.slideMenuView(
                self,
                dividerForSectionAt: section
            ) {
                menuItemsStackView.addArrangedSubview(dividerForSection)
            }
            let menuSectionView = SlideMenuSectionView()
            let menuSectionHeaderView = slideMenuViewDataSource.slideMenuView(
                self,
                headerForSectionAt: section
            )
            let menuSectionHeaderHeight = slideMenuViewDataSource.slideMenuView(
                self,
                heightForHeaderInSection: section
            )
            menuSectionView.set(
                headerView: menuSectionHeaderView,
                height: menuSectionHeaderHeight
            )
            menuItemsStackView.addArrangedSubview(menuSectionView)
            let numberOfItems = slideMenuViewDataSource.slideMenuView(
                self, numberOfItemsInSection: section
            )
            for item in 0..<numberOfItems {
                if let dividerForItem = slideMenuViewDataSource.slideMenuView(
                    self,
                    dividerForItemAt: IndexPath(item: item, section: section)
                ) {
                    menuSectionView.append(divider: dividerForItem)
                }
                let menuItemViewIndexPath = IndexPath(item: item, section: section)
                let menuItemView = slideMenuViewDataSource.slideMenuView(
                    self,
                    itemAt: menuItemViewIndexPath
                )
                menuItemView.indexPath = menuItemViewIndexPath
                menuItemView.addGestureRecognizer(UITapGestureRecognizer(
                    target: self,
                    action: #selector(handleMenuItemViewTapEvent))
                )
                let menuItemViewHeight = slideMenuViewDataSource.slideMenuView(
                    self,
                    heightForItemAt: menuItemViewIndexPath
                )
                menuSectionView.append(
                    menuItemView: menuItemView,
                    height: menuItemViewHeight
                )
            }
        }
    }

    @objc
    private func handleMenuItemViewTapEvent(sender: UITapGestureRecognizer) {
        guard let slideMenuViewDelegate = slideMenuViewDelegate else {
            return
        }
        guard let indexPath = (sender.view as? SlideMenuItemView)?.indexPath else {
            return
        }
        slideMenuViewDelegate.slideMenuView(self, didSelectItemAt: indexPath)
    }
}
