import Foundation


public class ShowSlideshowAction: NSObject {
    
    public static let instance = ShowSlideshowAction()
    
    private override init() {
        super.init()
    }
    
}

public class ShowSlideshowUseCase: NSObject {
    
    private let googleAnalyticRepository: GoogleAnalyticRepository
    
    public init(googleAnalyticRepository: GoogleAnalyticRepository) {
        self.googleAnalyticRepository = googleAnalyticRepository
    }
    
    public func invoke(eventName: String, eventParameters: EventParameters) -> ShowSlideshowAction {
        googleAnalyticRepository.sendEvent(name: eventName, parameters: eventParameters)
        return ShowSlideshowAction.instance
    }
    
}
