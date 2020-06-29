import Foundation

public class ShowTutorialAction {
    
    public static let instance = ShowTutorialAction()
    
    private init() {}
}

public class ShowTutorialUseCase: NSObject {
    
    private let googleAnalyticRepository: GoogleAnalyticRepository
    
    public init(googleAnaliticRepository: GoogleAnalyticRepository) {
        self.googleAnalyticRepository = googleAnaliticRepository
        super.init()
    }
    
    public func invoke(eventName: String, eventParameters: EventParameters) -> ShowTutorialAction {
        googleAnalyticRepository.sendEvent(name: eventName, parameters: eventParameters)
        return ShowTutorialAction.instance
    }
}
