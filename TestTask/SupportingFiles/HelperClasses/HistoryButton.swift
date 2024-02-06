import UIKit

class HistoryButton: UIView {
    private lazy var historyImage = UIImageView(image: UIImage(named: "history"))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(historyImage)
        self.backgroundColor = .blazeOrange
        self.layer.cornerRadius = 35
        
        NSLayoutConstraint.activate([
            historyImage.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            historyImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13),
            historyImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13),
            historyImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
        ])
    }
}
