import Lottie
import UIKit

final class PreloaderViewController: UIViewController {
    var coordinator: PreloaderCoordinator?
    private lazy var roundedSquareView = UIView(cornerRadius: 30, backgroundColor: .orange)
    private lazy var loadingAnimationView = LottieAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLottieView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(roundedSquareView, loadingAnimationView)
        
        NSLayoutConstraint.activate([
            roundedSquareView.heightAnchor.constraint(equalToConstant: 123),
            roundedSquareView.widthAnchor.constraint(equalToConstant: 123),
            roundedSquareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roundedSquareView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingAnimationView.heightAnchor.constraint(equalToConstant: 34),
            loadingAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -114),
            loadingAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 141),
            loadingAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -141)
        ])
    }
    
    private func setupLottieView() {
        loadingAnimationView.animation = LottieAnimation.named("Loading")
        loadingAnimationView.loopMode = .repeat(3)
        loadingAnimationView.contentMode = .scaleAspectFill
        loadingAnimationView.configuration.renderingEngine = .mainThread
        loadingAnimationView.play { [weak self] finished in
            
            if finished {
                self?.coordinator?.finish()
            }
        }
    }
}
