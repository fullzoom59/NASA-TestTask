import UIKit

protocol DatePickerDelegate: AnyObject {
    func didSelectDate(longDate: String, shortDate: String)
}

final class DateViewController: UIViewController {
    weak var delegate: DatePickerDelegate?
    var coordinator: DateCoordinator?
    private let dateViewModel = DateViewModel()
    
    private lazy var containerView = UIView(cornerRadius: 50, backgroundColor: .customWhite)
    private lazy var dateLabel = UILabel(text: "Date", font: .title2, textColor: .black)
    private lazy var closeButton: CircleButton = {
        let button = CircleButton(buttonType: .close)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonPressed(_:)))
        button.addGestureRecognizer(tapGesture)
        return button
    }()

    private lazy var tickButton: CircleButton = {
        let button = CircleButton(buttonType: .tick)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tickButtonPressed(_:)))
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    private lazy var datePicker = DatePicker()
    
    init(selectedDate: Date) {
        super.init(nibName: nil, bundle: nil)
        self.datePicker.date = selectedDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction private func closeButtonPressed(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @IBAction private func tickButtonPressed(_ sender: UITapGestureRecognizer) {
        let selectedDate = datePicker.date
        let longDate = dateViewModel.formatDateForLongFormat(date: selectedDate)
        let shortDate = dateViewModel.formatDateForShortFormat(date: selectedDate)
        
        delegate?.didSelectDate(longDate: longDate, shortDate: shortDate)
        dismiss(animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubviews(containerView)
        containerView.addSubviews(dateLabel, closeButton, tickButton, datePicker)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 312),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28),
            dateLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            tickButton.heightAnchor.constraint(equalToConstant: 44),
            tickButton.widthAnchor.constraint(equalToConstant: 44),
            tickButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            tickButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24),
            datePicker.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 28),
            datePicker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -28),
            datePicker.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
}
