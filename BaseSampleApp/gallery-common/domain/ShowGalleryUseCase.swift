import Foundation

public class ShowGalleryAction: NSObject {
    
    public static let instance = ShowGalleryAction()
    
    private override init() {
        super.init()
    }
}

public class ShowGalleryUseCase: NSObject {
    
    
    private let googleAnalyticRepository: GoogleAnalyticRepository
    
    public init(googleAnalyticRepository: GoogleAnalyticRepository) {
        self.googleAnalyticRepository = googleAnalyticRepository
    }
    
    public func invoke(eventName: String, eventParameters: EventParameters) -> ShowGalleryAction {
        googleAnalyticRepository.sendEvent(name: eventName, parameters: eventParameters)
        return ShowGalleryAction.instance
    }
}
