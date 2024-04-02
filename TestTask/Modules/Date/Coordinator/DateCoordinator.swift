import UIKit

class DateCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    weak var homeViewController: HomeViewController?
    var date: Date
    
    init(navigationController: UINavigationController?, homeViewController: HomeViewController, date: Date) {
        self.navigationController = navigationController
        self.homeViewController = homeViewController
        self.date = date
    }
    
    func start() {
        let vc = DateViewController(selectedDate: date)
        vc.coordinator = self
        vc.delegate = homeViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController?.present(vc, animated: true)
    }
}
