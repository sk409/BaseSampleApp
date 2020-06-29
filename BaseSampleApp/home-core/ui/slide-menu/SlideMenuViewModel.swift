
public class SlideMenuViewModel: ViewModel {
    
    public let eventDispatcher: EventDispatcher<SlideMenuActions>
    private let showGalleryUseCase: ShowGalleryUseCase
    private let showSlideshowUseCase: ShowSlideshowUseCase
    
    public init(
        eventDispatcher: EventDispatcher<SlideMenuActions>,
        showGalleryUseCase: ShowGalleryUseCase,
        showSlideshowUseCase: ShowSlideshowUseCase
    ) {
        self.eventDispatcher = eventDispatcher
        self.showGalleryUseCase = showGalleryUseCase
        self.showSlideshowUseCase = showSlideshowUseCase
    }
    
    public func onGalleryClicked() {
        _ = showGalleryUseCase.invoke(eventName: "tap_gallery", eventParameters: EventParameters())
        eventDispatcher.dispatchEvent { $0.showGallery() }
    }
    
    public func onSlideshowClicked() {
        _ = showSlideshowUseCase.invoke(eventName: "tap_slideshow", eventParameters: EventParameters())
        eventDispatcher.dispatchEvent { $0.showSlideshow() }
    }
}
