import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    var currentImageIdentifier: String?
    static let identifier = "\(HomeCollectionViewCell.self)"
    private lazy var containerView = UIView(cornerRadius: 12, backgroundColor: .customWhite)
    private lazy var roverLabel = DynamicFontLabel()
    private lazy var cameraLabel = DynamicFontLabel(numberOfLines: 0)
    private lazy var dateLabel = DynamicFontLabel()
    
    lazy var snapshotImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(model: Photo) {
        roverLabel.setDynamicFont(regularText: "Rover: ", boldText: model.rover?.name ?? "name")
        cameraLabel.setDynamicFont(regularText: "Camera: ", boldText: model.camera?.fullName ?? "camera")
        dateLabel.setDynamicFont(regularText: "Date: ", boldText: model.earthDate ?? "Date")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        snapshotImage.image = nil
        roverLabel.text = nil
        cameraLabel.text = nil
        dateLabel.text = nil
    }
    
    private func setupUI() {
        
        addSubviews(containerView)
        containerView.addSubviews(roverLabel, cameraLabel, dateLabel, snapshotImage)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            snapshotImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            snapshotImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            snapshotImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            snapshotImage.heightAnchor.constraint(equalToConstant: 130),
            snapshotImage.widthAnchor.constraint(equalToConstant: 130)
        ])
        
        NSLayoutConstraint.activate([
            roverLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 26),
            roverLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            cameraLabel.topAnchor.constraint(equalTo: roverLabel.bottomAnchor, constant: 6),
            cameraLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            cameraLabel.trailingAnchor.constraint(equalTo: snapshotImage.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: cameraLabel.bottomAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -27)
        ])
    }
}
