import Foundation

struct ViewModelFactoryImpl: ViewModelFactory {
    

    private let userDefaults = UserDefaults.standard
        
    private let googleAnalyticRepository: GoogleAnalyticRepository
    private let splashRepository: SplashRepository
    private let tutorialRepository: TutorialRepository
    
    init() {
        googleAnalyticRepository = GoogleAnalyticRepositoryImpl()
        splashRepository = SplashRepositoryImpl()
        tutorialRepository = TutorialRepositoryImpl(userDefaults: userDefaults)
    }
    
    func create<T: ViewModel>(_ metatype: T.Type) -> T? {
        switch metatype {
        case is HomeViewModel.Type:
            return HomeViewModel(
                eventDispatcher: EventDispatcher(),
                loadHomeUseCase: createLoadHomeUseCase()
            ) as? T
        case is SplashViewModel.Type:
            return SplashViewModel(
                eventDispatcher: EventDispatcher(),
                loadSplashUseCase: createLoadSplashUseCase()
                ) as? T
        case is TutorialViewModel.Type:
            return TutorialViewModel(
                eventDispatcher: EventDispatcher(),
                showHomeUseCase: createTutorialShowHomeUseCase()
            ) as? T
        case is SlideMenuViewModel.Type:
            return SlideMenuViewModel(
                eventDispatcher: EventDispatcher(),
                showGalleryUseCase: createShowGalleryUseCase(),
                showSlideshowUseCase: createShowSlideshowUseCase()
            ) as? T
        case is SlideshowViewModel.Type:
            return SlideshowViewModel(
                eventDispatcher: EventDispatcher(),
                backUseCase: createBackUseCase()
            ) as? T
        case is GalleryViewModel.Type:
            return GalleryViewModel(
                eventDispatcher: EventDispatcher(),
                backUseCase: createBackUseCase()
            ) as? T
        default:
            return nil
        }
    }
    
    private func createBackUseCase() -> BackUseCase {
        return BackUseCase(googleAnalyticRepository: googleAnalyticRepository)
    }
    
    private func createShowGalleryUseCase() -> ShowGalleryUseCase {
        return ShowGalleryUseCase(googleAnalyticRepository: googleAnalyticRepository)
    }
    
    public func createShowSlideshowUseCase() -> ShowSlideshowUseCase {
        return ShowSlideshowUseCase(googleAnalyticRepository: googleAnalyticRepository)
    }
    
    private func createLoadSplashUseCase() -> LoadSplashUseCase {
        return LoadSplashUseCase(
            splashRepository: splashRepository,
            tutorialRepository: tutorialRepository
        )
    }
    
    private func createLoadHomeUseCase() -> LoadHomeUseCase {
        return LoadHomeUseCase(splashRepository: splashRepository)
    }
    
    private func createTutorialShowHomeUseCase() -> TutorialShowHomeUseCase {
        return TutorialShowHomeUseCase(
            googleAnalyticRepository: googleAnalyticRepository,
            tutorialRepository: tutorialRepository
        )
    }
}
