import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "\(HistoryCollectionViewCell.self)"
    private lazy var containerView = UIView(cornerRadius: 12, backgroundColor: .customWhite)
    private lazy var filtersLabel = UILabel(text: "Filters", font: .title2, textColor: .blazeOrange)
    private lazy var spacerLine = UIView(backgroundColor: .blazeOrange)
    private lazy var roverLabel = DynamicFontLabel(numberOfLines: 1)
    private lazy var cameraLabel = DynamicFontLabel(numberOfLines: 1)
    private lazy var dateLabel = DynamicFontLabel(numberOfLines: 1)
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func configure(model: HistoryObject) {
        roverLabel.setDynamicFont(regularText: "Rover: ", boldText: model.rover)
        cameraLabel.setDynamicFont(regularText: "Camera: ", boldText: model.camera)
        dateLabel.setDynamicFont(regularText: "Date: ", boldText: model.longDate)
    }
    
    private func setupUI() {
        addSubviews(containerView)
        containerView.addSubviews(filtersLabel, spacerLine, roverLabel, cameraLabel, dateLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            filtersLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            filtersLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            spacerLine.heightAnchor.constraint(equalToConstant: 1),
            spacerLine.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            spacerLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            spacerLine.trailingAnchor.constraint(equalTo: filtersLabel.leadingAnchor, constant: -6)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            cameraLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -6),
            cameraLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            cameraLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            roverLabel.bottomAnchor.constraint(equalTo: cameraLabel.topAnchor, constant: -6),
            roverLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
    }
}
