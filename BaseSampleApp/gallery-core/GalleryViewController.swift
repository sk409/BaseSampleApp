import UIKit

public class GalleryViewController: BackableViewController<GalleryActionsImpl, GalleryViewModel>, GalleryActions {
    
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
            super.init(nibName: "GalleryViewController", bundle: nil)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        viewModel = viewModelFactory.create(GalleryViewModel.self)
        super.viewWillAppear(animated)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func setupViewModel(_ viewModel: GalleryViewModel?) {
        let actions = GalleryActionsImpl(self)
        viewModel?.eventDispatcher.bind(lifecycleOwner: self, listener: actions)
    }
    
    override public func setupDataBinding() {
        guard let viewModel = viewModel else {
            return
        }
        label.bindText(lifecycleOwner: self, liveData: viewModel.text)
    }
}

