import UIKit

extension UILabel {
    convenience init(text: String? = "", font: UIFont? = nil, textColor: UIColor? = nil, numberOfLines: Int = 0) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
    }
}
