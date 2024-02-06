import UIKit

class HistoryNavigationBar: UIView {
    public var navigationController: UINavigationController?
    private lazy var historyTitle = UILabel(text: "History", font: .largeTitle, textColor: .black)
    private lazy var arrowLeftButton: CircleButton = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(popViewController))
        let button = CircleButton(buttonType: .arrowLeft)
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    @IBAction private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .blazeOrange
        addSubviews(arrowLeftButton, historyTitle)
        
        NSLayoutConstraint.activate([
            arrowLeftButton.heightAnchor.constraint(equalToConstant: 44),
            arrowLeftButton.widthAnchor.constraint(equalToConstant: 44),
            arrowLeftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            arrowLeftButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            historyTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            historyTitle.centerYAnchor.constraint(equalTo: arrowLeftButton.centerYAnchor)
        ])
        
    }
}
