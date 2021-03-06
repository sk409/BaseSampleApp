import UIKit

public class SlideshowViewController: BackableViewController<SlideshowActionsImpl, SlideshowViewModel>, SlideshowActions
{
    
    private let viewModelFactory: ViewModelFactory
    private let viewControllerFactory: ViewControllerFactory
    @IBOutlet private weak var label: UILabel!
    
    public init(
        viewModelFactory: ViewModelFactory,
        viewControllerFactory: ViewControllerFactory
    ) {
        self.viewModelFactory = viewModelFactory
        self.viewControllerFactory = viewControllerFactory
//        let pod = Bundle(for: SplashViewController.self)
//        let path = pod.path(forResource: "Splash", ofType: "bundle")!
//        let bundle = Bundle(path: path)
//        super.init(nibName: "SplashViewController", bundle: bundle)
        super.init(nibName: "SlideshowViewController", bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        viewModel = viewModelFactory.create(SlideshowViewModel.self)
        super.viewWillAppear(animated)
    }

    public override func setupViewModel(_ viewModel: SlideshowViewModel?) {
        let actions = SlideshowActionsImpl(self)
        viewModel?.eventDispatcher.bind(lifecycleOwner: self, listener: actions)
    }
    
    public override func setupDataBinding() {
        guard let viewModel = viewModel else {
            return
        }
        label.bindText(lifecycleOwner: self, liveData: viewModel.text)
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
