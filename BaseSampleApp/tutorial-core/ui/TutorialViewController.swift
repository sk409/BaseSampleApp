import UIKit

public class TutorialViewController: MvvmViewController<TutorialViewModel> {
    
    private class TutorialActionsImpl: NSObject, TutorialActions {
        
        private weak var vc: TutorialViewController?
        
        init(_ vc: TutorialViewController) {
            self.vc = vc
        }
        
        func showHome() {
            vc?.showHome()
        }
    }
    
    public init(viewModelFactory: ViewModelFactory) {
//        let pod = Bundle(for: TutorialViewController.self)
//        let path = pod.path(forResource: "Tutorial", ofType: "bundle")!
//        let bundle = Bundle(path: path)
//        super.init(nibName: "TutorialViewController", bundle: bundle)
        super.init(nibName: "TutorialViewController", bundle: nil, viewModel:  viewModelFactory.create(TutorialViewModel.self))
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setupViewModel(_ viewModel: TutorialViewModel?) {
        let actions = TutorialActionsImpl(self)
        viewModel?.eventDispatcher.bind(lifecycleOwner: self, listener: actions)
    }
    
    //============================================================
    // region HomeActions
    //============================================================
    
    public func showHome() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // endregion HomeActions
    
    @IBAction func onHomeClicked(_ sender: Any) {
        viewModel?.onHomeClicked()
    }
}
