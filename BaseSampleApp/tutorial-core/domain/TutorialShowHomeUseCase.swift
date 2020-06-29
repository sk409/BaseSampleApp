import Foundation

public class TutorialShowHomeUseCase: ShowHomeUseCase {
    
    private var tutorialRepository: TutorialRepository
    
    public init(
        googleAnalyticRepository: GoogleAnalyticRepository,
        tutorialRepository: TutorialRepository
    ) {
        self.tutorialRepository = tutorialRepository
        super.init(googleAnalyticRepository: googleAnalyticRepository)
    }
    
    override public func invoke(eventName: String, eventParameters: EventParameters) {
        tutorialRepository.isAlreadyShown = true
        super.invoke(eventName: eventName, eventParameters: eventParameters)
    }
}
