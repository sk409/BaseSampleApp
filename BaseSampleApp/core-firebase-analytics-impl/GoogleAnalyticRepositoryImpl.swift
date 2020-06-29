import Foundation
import Firebase

public class GoogleAnalyticRepositoryImpl: NSObject, GoogleAnalyticRepository {
    
    override public init() {
        super.init()
    }
    
    public func sendEvent(name: String, parameters: EventParameters) {
        Analytics.logEvent(name, parameters: toDictionary(parameters))
    }
    
    private func toDictionary(_ eventParameters: EventParameters) -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        eventParameters.processString { key, value in
            dictionary[key] = value
        }
        eventParameters.processInt { key, value in
            dictionary[key] = value
        }
        eventParameters.processLong { key, value in
            dictionary[key] = value
        }
        eventParameters.processFloat { key, value in
            dictionary[key] = value
        }
        return dictionary
    }
}
