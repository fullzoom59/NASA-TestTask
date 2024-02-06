import UIKit

protocol HomeNavigationBarDelegate: AnyObject {
    func roverButtonPressed()
    func cameraButtonPressed()
    func calendarButtonPressed()
    func saveFiltersButtonPressed()
}

class HomeNavigationBar: UIView {
    weak var delegate: HomeNavigationBarDelegate?
    lazy var cameraLabel = UILabel(text: "MARS.CAMERA", font: .largeTitle, numberOfLines: 1)
    lazy var dateLabel = UILabel(text: "June 6, 2019", font: .body2, textColor: .black, numberOfLines: 1)
    
    lazy var roverButton: FilterButton = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(roverButtonPressed(_:)))
        let button = FilterButton(buttonType: .roverType)
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    lazy var cameraButton: FilterButton = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cameraButtonPressed(_:)))
        let button = FilterButton(buttonType: .camera)
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    private lazy var createButton: CreateButton = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(saveFiltersButtonPressed(_:)))
        let button = CreateButton()
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    private lazy var calendarButton: CalendarButton = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(calendarButtonPressed(_:)))
        let button = CalendarButton()
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .blazeOrange
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction private func roverButtonPressed(_ sender: UITapGestureRecognizer) {
        delegate?.roverButtonPressed()
    }
    
    @IBAction private func cameraButtonPressed(_ sender: UITapGestureRecognizer) {
        delegate?.cameraButtonPressed()
    }
    
    @IBAction private func calendarButtonPressed(_ sender: UITapGestureRecognizer) {
        delegate?.calendarButtonPressed()
    }
    
    @IBAction private func saveFiltersButtonPressed(_ sender: UITapGestureRecognizer) {
        delegate?.saveFiltersButtonPressed()
    }
    
    func setupUI() {
        addSubviews(cameraLabel, dateLabel, roverButton, cameraButton, createButton, calendarButton)
        
        NSLayoutConstraint.activate([
            cameraLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cameraLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            cameraLabel.trailingAnchor.constraint(equalTo: calendarButton.leadingAnchor, constant: -19)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: cameraLabel.bottomAnchor, constant: 2),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19)
        ])
        
        NSLayoutConstraint.activate([
            roverButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            roverButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            roverButton.heightAnchor.constraint(equalToConstant: 38),
            roverButton.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            cameraButton.leadingAnchor.constraint(equalTo: roverButton.trailingAnchor, constant: 12),
            cameraButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            cameraButton.heightAnchor.constraint(equalToConstant: 38),
            cameraButton.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            createButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            createButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            createButton.heightAnchor.constraint(equalToConstant: 38),
            createButton.widthAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            calendarButton.heightAnchor.constraint(equalToConstant: 44),
            calendarButton.widthAnchor.constraint(equalToConstant: 44),
            calendarButton.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -32),
            calendarButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17)
        ])
    }
}
