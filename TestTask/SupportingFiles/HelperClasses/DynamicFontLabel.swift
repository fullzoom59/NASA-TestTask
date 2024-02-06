import UIKit

class DynamicFontLabel: UILabel {
    private let normalAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.body,
        .foregroundColor: UIColor.lightGray
    ]
    
    private let boldAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldBody,
        .foregroundColor: UIColor.black
        
    ]
    
    init(numberOfLines: Int = 1) {
        super.init(frame: .zero)
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDynamicFont(regularText: String, boldText: String) {
        let combinedText = NSMutableAttributedString(string: regularText, attributes: normalAttributes)
        let boldString = NSAttributedString(string: boldText, attributes: boldAttributes)
        combinedText.append(boldString)
        
        self.attributedText = combinedText
    }
}
