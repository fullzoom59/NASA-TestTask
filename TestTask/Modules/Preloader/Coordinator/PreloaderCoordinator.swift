import UIKit
import OrderedCollections

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class InitializeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if UserDefaults.standard.bool(forKey: "appLaunchedBefore") {
            let mainCoordinator = HomeCoordinator(navigationController: navigationController)
            mainCoordinator.start()
        } else {
            let onboardingCoordinator = PreloaderCoordinator(navigationController: navigationController)
            onboardingCoordinator.start()
        }
    }
    
}

class PreloaderCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = PreloaderViewController()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func finish() {
        UserDefaults.standard.set(true, forKey: "appLaunchedBefore")
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
}
