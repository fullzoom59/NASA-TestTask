import UIKit

class CalendarButton: UIView {
    private lazy var calendarImage = UIImageView(image: UIImage(named: "calendar"))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        addSubviews(calendarImage)
        
        NSLayoutConstraint.activate([
            calendarImage.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            calendarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            calendarImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            calendarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
