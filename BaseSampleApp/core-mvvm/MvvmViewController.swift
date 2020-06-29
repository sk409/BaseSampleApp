import UIKit

open class MvvmViewController<VM: ViewModel>: LifecycleObservableViewController {
    
    public var viewModel: VM?
    
    public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewModel: VM?) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel(viewModel)
        setupDataBinding()
    }
    
    open func setupViewModel(_ viewModel: VM?) {
        fatalError("This method must be overridden in sub class")
    }
    
    open func setupDataBinding() {
    }
}
