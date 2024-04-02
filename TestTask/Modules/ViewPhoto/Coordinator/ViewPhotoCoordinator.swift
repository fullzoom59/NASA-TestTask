import UIKit

class ViewPhotoCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    var image: UIImage?
    
    init(navigationController: UINavigationController?, image: UIImage?) {
        self.navigationController = navigationController
        self.image = image
    }
    
    func start() {
        let vc = ViewPhotoViewController(spaceImage: image)
        vc.coordinator = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController?.present(vc, animated: false)
    }
}
