
public class GalleryViewModel: BackableViewModel<GalleryActionsImpl> {
    
    private let _text = MutableLiveData(initialValue: "This is gallery ViewController")
    
    let text: LiveData<String>
    
    public init(eventDispatcher: EventDispatcher<GalleryActionsImpl>, backUseCase: BackUseCase) {
        text = _text
        super.init(
            eventDispatcher: eventDispatcher,
            backUseCase: backUseCase,
            backEventName: "click_gallery_back",
            backEventParameters: EventParameters()
        )
    }
}
