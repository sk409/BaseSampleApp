import Foundation

private let IS_TUTORIAL_ALREADY_SHOWN_KEY = "IS_TUTORIAL_ALREADY_SHOWN"

public class TutorialRepositoryImpl: TutorialRepository {
    
    public var isAlreadyShown: Bool {
        didSet {
            userDefaults.set(isAlreadyShown, forKey: IS_TUTORIAL_ALREADY_SHOWN_KEY)
        }
    }
    
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults) {
        isAlreadyShown =  userDefaults.bool(forKey: IS_TUTORIAL_ALREADY_SHOWN_KEY)
//        isAlreadyShown = false
        self.userDefaults = userDefaults
    }
}
