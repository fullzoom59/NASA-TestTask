import UIKit

protocol FilterSelectedDelegate: AnyObject {
    func filterSelected(type: FilterButtonType, filter: String)
}

final class FilterViewController: UIViewController {
    var coordinator: FilterCoordinator?
    weak var delegate: FilterSelectedDelegate?
    private var filterViewModel: FilterViewModel
    private lazy var filterLabel = UILabel(font: .title2, textColor: .black, numberOfLines: 1)
    private lazy var closeButton: CircleButton = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonPressed(_:)))
        let button = CircleButton(buttonType: .close)
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    private lazy var tickButton: CircleButton = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tickButtonPressed(_:)))
        let button = CircleButton(buttonType: .tick)
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    init(title: String, dataSource: [String], filterButton: FilterButtonType, selectedFilter: String) {
        let selectedFilter = dataSource.firstIndex(where: { $0 == selectedFilter }) ?? 0
        filterViewModel = FilterViewModel(dataSource: dataSource, selectedFilter: selectedFilter, buttonType: filterButton)
        super.init(nibName: nil, bundle: nil)
        filterLabel.text = title
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredContentSize: CGSize {
        get {
            return CGSize(width: super.preferredContentSize.width, height: 306)
        }
        set { super.preferredContentSize = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.selectRow(filterViewModel.selectedFilter, inComponent: 0, animated: false)
        setupUI()
    }
    
    private func setupUI() {
        view.layer.cornerRadius = 50
        view.backgroundColor = .customWhite
        view.addSubviews(filterLabel, closeButton, tickButton, pickerView)
        
        NSLayoutConstraint.activate([
            filterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            filterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 28)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            tickButton.heightAnchor.constraint(equalToConstant: 44),
            tickButton.widthAnchor.constraint(equalToConstant: 44),
            tickButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tickButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 50),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @IBAction private func closeButtonPressed(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @IBAction private func tickButtonPressed(_ sender: UITapGestureRecognizer) {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        delegate?.filterSelected(type: filterViewModel.buttonType, filter: filterViewModel.dataSource[selectedRow])
        dismiss(animated: true)
    }
}

extension FilterViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterViewModel.dataSource.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension FilterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filterViewModel.dataSource[row]
    }
}

class CustomPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        let height: CGFloat = 306
        guard let containerView = containerView else {
            return .zero
        }
        
        let bounds = containerView.bounds
        let width = bounds.width
        return CGRect(x: 0, y: bounds.height - height, width: width, height: height)
    }
}
