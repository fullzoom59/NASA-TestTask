import UIKit

enum FilterButtonType {
    case camera
    case roverType
    
    var image: UIImage? {
        switch self {
        case .camera:
            return UIImage(named: "camera")
        case .roverType:
            return UIImage(named: "cpu")
        }
    }
}

class FilterButton: UIView {
    private var filterImage: UIImageView
    lazy var filterLabel = UILabel(text: "All", font: .body2, textColor: .black, numberOfLines: 1)
    
    init(buttonType: FilterButtonType) {
        self.filterImage = UIImageView(image: buttonType.image)
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        addSubviews(filterImage, filterLabel)
        
        NSLayoutConstraint.activate([
            filterImage.heightAnchor.constraint(equalToConstant: 24),
            filterImage.widthAnchor.constraint(equalToConstant: 24),
            filterImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            filterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7)
        ])
        
        NSLayoutConstraint.activate([
            filterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            filterLabel.leadingAnchor.constraint(equalTo: filterImage.trailingAnchor, constant: 6),
            filterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)
        ])
    }
}
