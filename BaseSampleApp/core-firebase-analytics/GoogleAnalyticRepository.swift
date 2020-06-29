
public protocol GoogleAnalyticRepository {
    
    func sendEvent(name: String, parameters: EventParameters)
}
