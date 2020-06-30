
public class SlideshowViewModel: BackableViewModel<SlideshowActionsImpl> {
    
    private let _text = MutableLiveData("This is slideshow ViewController")
    
    public let text: LiveData<String>
    
    public init(eventDispatcher: EventDispatcher<SlideshowActionsImpl>, backUseCase: BackUseCase) {
        text = _text
        super.init(
            eventDispatcher: eventDispatcher,
            backUseCase: backUseCase,
            backEventName: "click_slideshow_back",
            backEventParameters: EventParameters()
        )
    }
    
}
