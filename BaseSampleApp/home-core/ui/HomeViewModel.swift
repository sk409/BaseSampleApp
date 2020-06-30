public class HomeViewModel: ViewModel {
    
    public let eventDispatcher: EventDispatcher<HomeActions>
    
    private let loadHomeUseCase: LoadHomeUseCase
    
    private let _text = MutableLiveData("")
    
    public let text: LiveData<String>
    
    public init(
        eventDispatcher: EventDispatcher<HomeActions>,
        loadHomeUseCase: LoadHomeUseCase
    ) {
        self.eventDispatcher = eventDispatcher
        self.loadHomeUseCase = loadHomeUseCase
        text = _text
        super.init()
    }
    
    public func start() {
        let result = loadHomeUseCase.invoke()
        switch result {
        case .showSplashAction:
            eventDispatcher.dispatchEvent { $0.showSplash() }
        case .result(let text):
            _text.value = text
        }
    }
}
