import UIKit

class SplashViewController: MvvmViewController<SplashViewModel> {
    
    
    private class SplashActionsImpl: SplashActions {
        
        private weak var vc: SplashViewController?
        
        init(_ vc: SplashViewController) {
            self.vc = vc
        }
        
        func showHome() {
            vc?.showHome()
        }
        
        func showTutorial() {
            vc?.showTutorial()
        }
    }
    
    private let viewControllerFactory: ViewControllerFactory
    
    public init(
        viewModelFactor: ViewModelFactory,
        viewControllerFactory: ViewControllerFactory
    ) {
        self.viewControllerFactory = viewControllerFactory
//        let pod = Bundle(for: SplashViewController.self)
//        let path = pod.path(forResource: "Splash", ofType: "bundle")!
//        let bundle = Bundle(path: path)
//        super.init(nibName: "SplashViewController", bundle: bundle)
        super.init(nibName: "SplashViewController", bundle: nil, viewModel: viewModelFactor.create(SplashViewModel.self))
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public override func setupViewModel(_ viewModel: SplashViewModel?) {
        let actions = SplashActionsImpl(self)
        viewModel?.eventDispatcher.bind(lifecycleOwner: self, listener: actions)
        viewModel?.start()
    }
    
    //============================================================
    // region SplashActions
    //============================================================
    
    open func showHome() {
        navigationController?.popViewController(animated: true)
    }
    
    open func showTutorial() {
        guard let tutorialViewController = viewControllerFactory.instantiate(TutorialViewController.self) else {
            return
        }
        navigationController?.pushViewController(tutorialViewController, animated: true)
    }
    
    // endregion SplashActions
}
