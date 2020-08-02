import UIKit

open class MvvmViewController<VM: ViewModel>: LifecycleObservableViewController {
    
    public var viewModel: VM?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel(viewModel)
        setupDataBinding()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.start()
    }
    
    open func setupViewModel(_ viewModel: VM?) {
        fatalError("This method must be overridden in sub class")
    }
    
    open func setupDataBinding() {
    }
}
