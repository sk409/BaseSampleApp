import Foundation

public enum LoadHomeAction {
    
    case showSplashAction
    
    case result(text: String)
}

public class LoadHomeUseCase: NSObject {
    
    private let splashRepository: SplashRepository
    
    public init(splashRepository: SplashRepository) {
        self.splashRepository = splashRepository
    }
    
    public func invoke() -> LoadHomeAction {
        if splashRepository.isAlreadyShown {
            Thread.sleep(forTimeInterval: 1)
            return .result(text: "This is home Fragment")
        }
        return .showSplashAction
    }
}
