import UIKit

open class LifecycleObservableViewController: UIViewController, LifecycleOwner {
    
    public var lifecycle = Lifecycle()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        lifecycle.owner = self
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func loadView() {
        super.loadView()
        lifecycle.onLoadView()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        lifecycle.onViewDidLoad()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifecycle.onViewWillAppear()
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        lifecycle.onViewWillLayoutSubviews()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lifecycle.onViewDidLayoutSubviews()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifecycle.onViewDidAppear()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifecycle.onViewWillDisappear()
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lifecycle.onViewDidDisappear()
    }
}
