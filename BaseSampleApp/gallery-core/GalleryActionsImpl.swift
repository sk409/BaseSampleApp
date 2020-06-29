import Foundation

public class GalleryActionsImpl: NSObject, GalleryActions {
    
    private weak var actions: GalleryActions?

    init(_ actions: GalleryActions) {
        self.actions = actions
    }

    public func back() {
        actions?.back()
    }
}
