import UIKit

class AppLauncherImpl: AppLauncher {
    func launch(window: UIWindow) {
        window.frame = UIScreen.main.bounds
        let viewControllerFactory = ViewControllerFactoryImpl()
        let navigationController = UINavigationController(rootViewController: viewControllerFactory.instantiate(HomeViewController.self)!)
        window.rootViewController = navigationController

        if #available(iOS 13.0, *) {
            window.backgroundColor = .systemBackground
        } else {
            window.backgroundColor = .white
        }

        window.makeKeyAndVisible()
    }
}
