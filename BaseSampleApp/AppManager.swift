import Foundation
import UIKit

class AppManager {
    
    private lazy var viewControllerFactory = ViewControllerFactoryImpl()
    
    func setRootScreen(appDelegate: AppDelegate) {
        if #available(iOS 13, *) {
            // Do nothing
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = createRootViewController()
            appDelegate.window = window
            window.makeKeyAndVisible()
        }
    }
    
    @available(iOS 13.0, *)
    func setRootScreen(sceneDelegate: SceneDelegate, windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = createRootViewController()
        sceneDelegate.window = window
        window.makeKeyAndVisible()
    }
    
    private func createRootViewController() -> UIViewController {
        return UINavigationController(rootViewController: viewControllerFactory.instantiate(HomeViewController.self)!)
    }
    
}

