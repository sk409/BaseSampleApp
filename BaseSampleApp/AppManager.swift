import Foundation
import UIKit
import Firebase

class AppManager {
    
    private lazy var viewControllerFactory = ViewControllerFactoryImpl()
    
    func initialize(appDelegate: AppDelegate) {
        if #available(iOS 13, *) {
            // Do nothing
        } else {
            configure()
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = createRootViewController()
            appDelegate.window = window
            window.makeKeyAndVisible()
        }
    }
    
    @available(iOS 13.0, *)
    func initialize(sceneDelegate: SceneDelegate, windowScene: UIWindowScene) {
        configure()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = createRootViewController()
        sceneDelegate.window = window
        window.makeKeyAndVisible()
    }
    
    private func configure() {
        FirebaseApp.configure()
    }
    
    private func createRootViewController() -> UIViewController {
        return UINavigationController(rootViewController: viewControllerFactory.instantiate(HomeViewController.self)!)
    }
    
}

