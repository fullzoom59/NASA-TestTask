import UIKit

final class ViewPhotoViewController: UIViewController {
    var coordinator: ViewPhotoCoordinator?
    private lazy var scrollView = UIScrollView()
    private lazy var imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "squareSnapshot"))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    private lazy var closeButton: CircleButton = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonPressed(_:)))
        let button = CircleButton(buttonType: .lightClose)
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupUI()
        addDoubleTap()
    }
    
    init(spaceImage: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = spaceImage
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction private func closeButtonPressed(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    private func setupScrollView() {
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 5
        scrollView.delegate = self
    }
    
    private func addDoubleTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        tapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction private func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: sender.location(in: sender.view)), animated: true )
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    private func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width = imageView.frame.size.width / scale
        let newCenter = imageView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2)
        return zoomRect
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubviews(scrollView, closeButton)
        scrollView.addSubviews(imageView)
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * 2 , height: scrollView.frame.size.height * 2)
        
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.5)
        ])
    }
}

extension ViewPhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
