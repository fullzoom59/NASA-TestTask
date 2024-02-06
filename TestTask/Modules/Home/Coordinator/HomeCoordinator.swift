import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var viewModel: HomeViewModel?

    init(navigationController: UINavigationController, viewModel: HomeViewModel? = nil) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
       
    func start() {
        let homeViewModel = self.viewModel ?? HomeViewModel(networkManager: NetworkManager(), urlGenerator: URLGenerator(), filterStrategy: HomeFilterStrategy())
           
        let vc = HomeViewController(viewModel: homeViewModel)
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func navigateToDate(controller: HomeViewController, date: Date) {
        let dateCoordinator = DateCoordinator(navigationController: navigationController, homeViewController: controller, date: date)
        dateCoordinator.start()
    }
    
    func navigateToFilter(controller: HomeViewController, model: FilterParameters) {
        let filterCoordinator = FilterCoordinator(navigationController: navigationController, homeViewController: controller, model: model)
        filterCoordinator.start()
    }
    
    func navigateToHistory() {
        let historyCoordinator = HistoryCoordinator(navigationController: navigationController)
        historyCoordinator.start()
    }
    
    func navigateToViewPhoto(image: UIImage?) {
        let viewPhotoCoordinator = ViewPhotoCoordinator(navigationController: navigationController, image: image)
        viewPhotoCoordinator.start()
    }
}
