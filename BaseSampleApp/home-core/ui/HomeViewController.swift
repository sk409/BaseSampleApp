import UIKit

public class HomeViewController: MvvmViewController<HomeViewModel> {
    
    private class HomeActionsImpl: NSObject, HomeActions {
        
        private weak var vc: HomeViewController?
        
        init(_ vc: HomeViewController) {
            self.vc = vc
        }
        
        func showSplash() {
            vc?.showSplash()
        }
    }
    
    private class SlideMenuActionsImpl: SlideMenuActions {
        
        private weak var vc: HomeViewController?
        
        init(_ vc: HomeViewController) {
            self.vc = vc
        }
        
        func showGallery() {
            vc?.showGallery()
        }
        
        func showSlideshow() {
            vc?.showSlideshow()
        }
        
    }
    
    public var slideMenuViewModel: SlideMenuViewModel?
    private var slideMenuViewController: SlideMenuViewController?
    
    private let viewModelFactory: ViewModelFactory
    private let viewControllerFactory: ViewControllerFactory
    
    public init(viewModelFactory: ViewModelFactory, viewControllerFactory: ViewControllerFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewControllerFactory = viewControllerFactory
//        let pod = Bundle(for: TutorialViewController.self)
//        let path = pod.path(forResource: "Tutorial", ofType: "bundle")!
//        let bundle = Bundle(path: path)
//        super.init(nibName: "TutorialViewController", bundle: bundle)
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        slideMenuViewModel = viewModelFactory.create(SlideMenuViewModel.self)
        viewModel = viewModelFactory.create(HomeViewModel.self)
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    public override func setupViewModel(_ viewModel: HomeViewModel?) {
        let homeActions = HomeActionsImpl(self)
        viewModel?.eventDispatcher.bind(lifecycleOwner: self, listener: homeActions)
        
        let slideMenuActions = SlideMenuActionsImpl(self)
        slideMenuViewModel?.eventDispatcher.bind(lifecycleOwner: self, listener: slideMenuActions)
    }
    
    //============================================================
    // region SlideMenuActions
    //============================================================
    
    public func showGallery() {
        guard let galleryViewController = viewControllerFactory.instantiate(GalleryViewController.self) else {
            return
        }
        slideMenuViewController?.dismiss(animated: false)
        navigationController?.pushViewController(galleryViewController, animated: true)
    }
    
    public func showSlideshow() {
        guard let slideshowViewController = viewControllerFactory.instantiate(SlideshowViewController.self) else {
            return
        }
        slideMenuViewController?.dismiss(animated: false)
        navigationController?.pushViewController(slideshowViewController, animated: true)
    }
    
    // endregion SlideMenuActions
    
    //============================================================
    // region HomeActions
    //============================================================
    
    public func showSplash() {
        guard let splashViewController = viewControllerFactory.instantiate(SplashViewController.self) else {
            return
        }
        navigationController?.pushViewController(splashViewController, animated: false)
    }
    
    // endregion HomeActions
    
    private func setupMenu() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "menu"),
            style: .plain,
            target: self,
            action: #selector(onSlideMenuTogglerTapped)
        )
    }
    
    @objc
    private func onSlideMenuTogglerTapped() {
        slideMenuViewController = viewControllerFactory.instantiate(SlideMenuViewController.self)
        guard let slideMenuViewController = slideMenuViewController else {
            return
        }
        slideMenuViewController.modalPresentationStyle = .overCurrentContext
        slideMenuViewController.slideMenuSections = createSlideMenuSections()
        present(slideMenuViewController, animated: false)
    }
    
    private func createSlideMenuSections() -> [SlideMenuSection] {
        var slideMenuSections = [SlideMenuSection]()
        let slideMenuItems = [
            createGallerySlideMenuItem(),
            createSlideshowSlideMenuItem(),
        ]
        let slideMenuSection = SlideMenuSection(
            title: nil,
            iconImage: nil,
            menuItems: slideMenuItems,
            collapsable: false
        )
        slideMenuSections.append(slideMenuSection)
        return slideMenuSections
    }
    
    private func createGallerySlideMenuItem() -> SlideMenuItem {
        return SlideMenuItem(
            title: "Gallery",
            iconImage: UIImage(named: "image-multiple"),
            insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
        {
            self.showGallery()
        }
    }
    
    private func createSlideshowSlideMenuItem() -> SlideMenuItem {
        return SlideMenuItem(
            title: "Slideshow",
            iconImage: UIImage(named: "play-box-multiple"),
            insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
        {
            self.showSlideshow()
        }
    }
}
