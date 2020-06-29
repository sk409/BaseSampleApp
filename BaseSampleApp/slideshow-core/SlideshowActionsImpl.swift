import Foundation

public class SlideshowActionsImpl: NSObject, SlideshowActions {

    private weak var actions: SlideshowActions?

    init(_ actions: SlideshowActions) {
        self.actions = actions
    }

    public func back() {
        actions?.back()
    }
}
