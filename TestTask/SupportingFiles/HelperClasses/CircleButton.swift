import UIKit

enum CircleButtonType {
    case arrowLeft
    case close
    case lightClose
    case tick
    
    
    var image: UIImage? {
        switch self {
        case .arrowLeft:
            return UIImage(named: "arrow-circle-left")
        case .close:
            return UIImage(named: "close")
        case .lightClose:
            return UIImage(named: "lightClose")
        case .tick:
            return UIImage(named: "tick")
        }
    }
}

class CircleButton: UIView {
    private var calendarImage: UIImageView
    
    init(buttonType: CircleButtonType) {
        calendarImage = UIImageView(image: buttonType.image)
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubviews(calendarImage)
        
        NSLayoutConstraint.activate([
            calendarImage.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            calendarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            calendarImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            calendarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ])
    }
}
