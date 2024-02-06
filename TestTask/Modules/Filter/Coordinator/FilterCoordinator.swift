import UIKit

class FilterCoordinator: Coordinator {
    var navigationController: UINavigationController
    weak var homeViewController: HomeViewController?
    var model: FilterParameters
    
    init(navigationController: UINavigationController, homeViewController: HomeViewController, model: FilterParameters) {
        self.navigationController = navigationController
        self.homeViewController = homeViewController
        self.model = model
    }
    
    func start() {
        let vc = FilterViewController(
            title: model.title,
            dataSource: model.dataSource,
            filterButton: model.filterButton,
            selectedFilter: model.selectedFilter
        )
        vc.coordinator = self
        vc.delegate = homeViewController
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = homeViewController
        navigationController.present(vc, animated: true)
    }
}
