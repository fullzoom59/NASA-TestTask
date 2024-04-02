import UIKit

class HistoryCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HistoryViewController()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setHomeViewController(shortDate: String, longDate: String, roverType: String, cameraType: String) {
        let networkManager = NetworkManager()
        let urlGenerator = URLGenerator()
        let filterStrategy = HomeFilterStrategy()
        let homeViewModel = HomeViewModel(networkManager: networkManager, urlGenerator: urlGenerator, filterStrategy: filterStrategy)
        homeViewModel.longDate = longDate
        homeViewModel.shortDate = shortDate
        homeViewModel.roverType = roverType
        homeViewModel.cameraType = cameraType
        
        let coordinator = HomeCoordinator(navigationController: navigationController, viewModel: homeViewModel)
        coordinator.start()
    }
}
