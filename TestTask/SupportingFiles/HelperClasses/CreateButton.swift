import UIKit

class CreateButton: UIView {
    private lazy var image = UIImageView(image: UIImage(named: "add"))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        addSubviews(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7)
        ])
    }
}
