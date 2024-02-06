import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}

extension UIView {
    convenience init(cornerRadius: CGFloat = 0, backgroundColor: UIColor? = .clear) {
        self.init(frame: .zero)
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
    }
}
