import UIKit

public struct ViewControllerFactoryImpl: ViewControllerFactory {
    
    
    let viewModelFactory = ViewModelFactoryImpl()
    
    public func instantiate<T: UIViewController>(_ metatype: T.Type) -> T? {
        switch metatype {
        case is HomeViewController.Type:
            return HomeViewController(viewModelFactory: viewModelFactory, viewControllerFactory: self) as? T
        case is SplashViewController.Type:
            return SplashViewController(viewModelFactor: viewModelFactory, viewControllerFactory: self) as? T
        case is TutorialViewController.Type:
            return TutorialViewController(viewModelFactory: viewModelFactory) as? T
        case is SlideMenuViewController.Type:
            return SlideMenuViewController() as? T
        case is SlideshowViewController.Type:
            return SlideshowViewController(viewModelFactory: viewModelFactory, viewControllerFactory: self) as? T
        case is GalleryViewController.Type:
            return GalleryViewController(viewModelFactory: viewModelFactory, viewControllerFactory: self) as? T
        default:
            return nil
        }
    }
    
}
