public class BackableViewModel<BN: BackNavigation>: ViewModel {
    
    public let eventDispatcher: EventDispatcher<BN>
    private let backUseCase: BackUseCase

    let backEventName: String

    let backEventParameters: EventParameters

    public init(eventDispatcher: EventDispatcher<BN>, backUseCase: BackUseCase, backEventName: String, backEventParameters: EventParameters) {
        self.eventDispatcher = eventDispatcher
        self.backUseCase = backUseCase
        self.backEventName = backEventName
        self.backEventParameters = backEventParameters
    }
    
    open func onBackClicked() {
        _ = backUseCase.invoke(eventName: backEventName, eventParameters: backEventParameters)
        eventDispatcher.dispatchEvent { $0.back() }
    }
}
