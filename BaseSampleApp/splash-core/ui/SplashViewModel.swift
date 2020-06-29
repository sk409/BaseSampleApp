import Foundation

public class SplashViewModel: ViewModel {
    
    public let eventDispatcher: EventDispatcher<SplashActions>
    private let loadSplashUseCase: LoadSplashUseCase
    
    public init(
        eventDispatcher: EventDispatcher<SplashActions>,
        loadSplashUseCase: LoadSplashUseCase
    ) {
        self.eventDispatcher = eventDispatcher
        self.loadSplashUseCase = loadSplashUseCase
    }
    
    public func start() {
        DispatchQueue.global().async {
            let splashAction = self.loadSplashUseCase.invoke()
            switch splashAction {
            case .topAction:
                self.eventDispatcher.dispatchEvent { $0.showHome() }
            case .tutorialAction:
                self.eventDispatcher.dispatchEvent { $0.showTutorial() }
            }
        }
    }
    
}
