import UIKit

open class BackableViewController<A: BackNavigation, VM: BackableViewModel<A>>: MvvmViewController<VM>, BackNavigation
{
    
    public init(nibName: String, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        guard let viewControllers = navigationController?.viewControllers else {
            return
        }
        var existSelfInViewControllers = true
        for viewController in viewControllers {
            if viewController == self {
                existSelfInViewControllers = false
                break
            }
        }
        if existSelfInViewControllers {
            viewModel?.onBackClicked()
        }
        super.viewWillDisappear(animated)
    }
    
    public func back() {
        navigationController?.popViewController(animated: true)
    }
    
}
