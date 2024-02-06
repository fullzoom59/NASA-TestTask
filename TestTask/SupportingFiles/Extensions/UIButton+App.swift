import UIKit

extension UIButton {
    convenience init(title: String, textColor: UIColor? = nil, font: UIFont? = nil) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = font
    }
}
