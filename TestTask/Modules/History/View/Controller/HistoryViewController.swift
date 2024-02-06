import UIKit

final class HistoryViewController: UIViewController {
    private let historyViewModel = HistoryViewModel()
    var coordinator: HistoryCoordinator?
    
    private lazy var historyNavigationBar: HistoryNavigationBar = {
        let navigationBar = HistoryNavigationBar()
        navigationBar.navigationController = self.navigationController
        return navigationBar
    }()
    
    private lazy var historyCollectionView: UICollectionView = {
        let cv = UICollectionView(delegate: self, dataSource: self)
        cv.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: HistoryCollectionViewCell.identifier)
        return cv
    }()
    
    private lazy var historyIsImptyImage = UIImageView(image: UIImage(named: "historyEmpty"))
    private lazy var browsingHistoryLabel = UILabel(text: "Browsing history is empty.", font: .body, textColor: .cloudyGray, numberOfLines: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationBarHidden()
        setupUI()
        configureCollectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        historyViewModel.loadObjects()
        updateUI()
    }
    
    func setNavigationBarHidden() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func configureCollectionViewLayout() {
        if let flowLayout = historyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.itemSize = CGSize(width: view.frame.width, height: 136)
            flowLayout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        }
    }
    
    private func setupUI() {
        view.addSubviews(historyNavigationBar, historyIsImptyImage, browsingHistoryLabel, historyCollectionView)
        
        NSLayoutConstraint.activate([
            historyNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            historyNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyNavigationBar.heightAnchor.constraint(equalToConstant: 132)
        ])
        
        NSLayoutConstraint.activate([
            historyIsImptyImage.heightAnchor.constraint(equalToConstant: 145),
            historyIsImptyImage.widthAnchor.constraint(equalToConstant: 145),
            historyIsImptyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            historyIsImptyImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            browsingHistoryLabel.topAnchor.constraint(equalTo: historyIsImptyImage.bottomAnchor, constant: 20),
            browsingHistoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            browsingHistoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
        
        NSLayoutConstraint.activate([
            historyCollectionView.topAnchor.constraint(equalTo: historyNavigationBar.bottomAnchor),
            historyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func updateUI() {
        if historyViewModel.historyObjects.isEmpty {
            historyCollectionView.isHidden = true
            historyIsImptyImage.isHidden = false
            browsingHistoryLabel.isHidden = false
        } else {
            historyCollectionView.reloadData()
            historyCollectionView.isHidden = false
            historyIsImptyImage.isHidden = true
            browsingHistoryLabel.isHidden = true
        }
    }
}

extension HistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyViewModel.historyObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.identifier, for: indexPath) as? HistoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(model: historyViewModel.historyObjects[indexPath.row])
        return cell
    }
}

extension HistoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Menu Filter", message: nil, preferredStyle: .actionSheet)
        let useAction = UIAlertAction(title: "Use", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            let model = self.historyViewModel.historyObjects[indexPath.row]
            coordinator?.setHomeViewController(shortDate: model.shortDate, longDate: model.longDate, roverType: model.rover, cameraType: model.camera)
        })
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            guard let self else { return }
            let objectID = self.historyViewModel.historyObjects[indexPath.row].id
            self.historyViewModel.removeObject(id: objectID, at: indexPath.row)
            self.updateUI()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(useAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
