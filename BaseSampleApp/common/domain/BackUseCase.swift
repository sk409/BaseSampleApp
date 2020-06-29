public enum BackAction {
    case backAction
}

public class BackUseCase {
    
    private let googleAnalyticRepository: GoogleAnalyticRepository
    
    public init(googleAnalyticRepository: GoogleAnalyticRepository) {
        self.googleAnalyticRepository = googleAnalyticRepository
    }
    
    public func invoke(eventName: String, eventParameters: EventParameters) -> BackAction {
        googleAnalyticRepository.sendEvent(name: eventName, parameters: eventParameters)
        return .backAction
    }
}
