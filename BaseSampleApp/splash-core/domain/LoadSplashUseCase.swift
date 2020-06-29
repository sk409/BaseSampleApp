import Foundation

public enum SplashAction {
    case tutorialAction
    case topAction
}

public class LoadSplashUseCase: NSObject {
    
    private var splashRepository: SplashRepository
    private let tutorialRepository: TutorialRepository
    
    public init(splashRepository: SplashRepository, tutorialRepository: TutorialRepository) {
        self.splashRepository = splashRepository
        self.tutorialRepository = tutorialRepository
    }
    
    public func invoke() -> SplashAction {
        Thread.sleep(forTimeInterval: 3)
        splashRepository.isAlreadyShown = true
        return tutorialRepository.isAlreadyShown ? .topAction : .tutorialAction
    }
}
