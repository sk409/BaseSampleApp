
open class EventParameters {
    
    private var stringData = [String: String]()
    private var intData = [String: Int]()
    private var longData = [String: Int64]()
    private var floatData = [String: Float]()
    
    open func put(key: String, value: String) {
        stringData[key] = value
    }
    
    open func put(key: String, value: Int) {
        intData[key] = value
    }
    
    open func put(key: String, value: Int64) {
        longData[key] = value
    }
    
    open func put(key: String, value: Float) {
        floatData[key] = value
    }
    
    open func processString(block: (String, String) -> Void) {
        stringData.forEach { key, value in
            block(key, value)
        }
    }
    
    open func processInt(block: (String, Int) -> Void) {
        intData.forEach { key, value in
            block(key, value)
        }
    }
    
    open func processLong(block: (String, Int64) -> Void) {
        longData.forEach{ key, value in
            block(key, value)
        }
    }
    
    open func processFloat(block: (String, Float) -> Void) {
        floatData.forEach { key, value in
            block(key, value)
        }
    }
}
