import Foundation

open class ShowHomeUseCase: NSObject {
    
    private let googleAnalyticRepository: GoogleAnalyticRepository
    
    public init(googleAnalyticRepository: GoogleAnalyticRepository) {
        self.googleAnalyticRepository = googleAnalyticRepository
        super.init()
    }
    
    open func invoke(eventName: String, eventParameters: EventParameters) {
        googleAnalyticRepository.sendEvent(name: eventName, parameters: eventParameters)
    }
}
