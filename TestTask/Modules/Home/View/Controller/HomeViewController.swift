import OrderedCollections
import UIKit

final class HomeViewController: UIViewController {
    private var homeViewModel: HomeViewModel
    var coordinator: HomeCoordinator?
    private lazy var homeNavigationBar: HomeNavigationBar = {
        let navigationBar = HomeNavigationBar()
        navigationBar.delegate = self
        return navigationBar
    }()

    private lazy var homeCollectionView: UICollectionView = {
        let cv = UICollectionView(delegate: self, dataSource: self)
        cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        return cv
    }()
    
    private lazy var historyButton: HistoryButton = {
        let button = HistoryButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(historyButtonPressed(_:)))
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: HomeViewModel) {
        self.homeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.homeNavigationBar.cameraLabel.text = homeViewModel.cameraType
        self.homeNavigationBar.cameraButton.filterLabel.text = homeViewModel.cameraType
        self.homeNavigationBar.roverButton.filterLabel.text = homeViewModel.roverType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureCollectionViewLayout()
        callAllNetworkMethods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeNavigationBar.dateLabel.text = homeViewModel.longDate
    }
    
    
    func callAllNetworkMethods() {
        let dispatchGroup = DispatchGroup()
        
        let roverTypes: [RoverType] = [.curiosity, .opportunity, .spirit]
        for roverType in roverTypes {
            dispatchGroup.enter()
            homeViewModel.fetchInformation(roverType: roverType) { result in
                switch result {
                case .success(let success):
                    switch roverType {
                    case .curiosity:
                        self.homeViewModel.allRovers.append(contentsOf: success)
                    case .opportunity:
                        self.homeViewModel.allRovers.append(contentsOf: success)
                    case .spirit:
                        self.homeViewModel.allRovers.append(contentsOf: success)
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.updateData()
        }
    }
    
    
    func loadMoreData() {
        homeViewModel.currentPage += 1
        callAllNetworkMethods()
    }
    
    func updateData() {
        self.homeViewModel.getAllRoversData()
        self.homeViewModel.filterArray()
        self.homeCollectionView.reloadData()
    }
    
    func scrollToTop() {
        let cellSize: CGFloat = 150
        let shouldScroll = self.homeCollectionView.contentOffset.y > cellSize - self.homeCollectionView.contentInset.top
        
        if shouldScroll {
            let numberOfItems = self.homeCollectionView.numberOfItems(inSection: 0)
            if numberOfItems > 0 {
                let indexPath = IndexPath(item: 0, section: 0)
                self.homeCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            }
        }
    }
    
    func setNavigationBarHidden() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func configureCollectionViewLayout() {
        if let flowLayout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.itemSize = CGSize(width: view.frame.width, height: 150)
            flowLayout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        }
    }
    
    @IBAction private func historyButtonPressed(_ sender: UITapGestureRecognizer) {
        coordinator?.navigateToHistory()
    }
    
    private func setupUI() {
        setNavigationBarHidden()
        view.addSubviews(homeNavigationBar, homeCollectionView, historyButton)
        
        NSLayoutConstraint.activate([
            homeNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            homeNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeNavigationBar.heightAnchor.constraint(equalToConstant: 202)
        ])
        
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: homeNavigationBar.bottomAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            historyButton.heightAnchor.constraint(equalToConstant: 70),
            historyButton.widthAnchor.constraint(equalToConstant: 70),
            historyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            historyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.selectedCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = homeViewModel.selectedCategory[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.prepareForReuse()
        cell.configure(model: model)

        let imageIdentifier = model.imgSrc
        cell.currentImageIdentifier = imageIdentifier

        if let image = model.imgSrc, let url = URL(string: image) {
            let size = CGSize(width: 600, height: 600)
            ImageCache.shared.downloadImage(from: url, imageSize: size) { [weak cell] snapshot in
                if cell?.currentImageIdentifier == imageIdentifier {
                    cell?.snapshotImage.image = snapshot
                }
            }
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell {
            coordinator?.navigateToViewPhoto(image: cell.snapshotImage.image)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == homeViewModel.selectedCategory.count - 5 && !homeViewModel.isLoading {
            loadMoreData()
        }
    }
}

extension HomeViewController: HomeNavigationBarDelegate {
    func roverButtonPressed() {
        let model = homeViewModel.filterParametersForRover()
        coordinator?.navigateToFilter(controller: self, model: model)
    }

    func cameraButtonPressed() {
        let model = homeViewModel.filterParametersForCamera()
        coordinator?.navigateToFilter(controller: self, model: model)
    }
    
    func calendarButtonPressed() {
        if let date = homeViewModel.getDateFromString() {
            coordinator?.navigateToDate(controller: self, date: date)
        }
    }
    
    func saveFiltersButtonPressed() {
        let alert = UIAlertController(title: "Save Filters", message: "The current filters and the date you have chosen can be saved to the filter history.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self else { return }
            let longDate = self.homeNavigationBar.dateLabel.text ?? ""
            self.homeViewModel.saveCurrentFilters(longDate: longDate)
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension HomeViewController: FilterSelectedDelegate {
    func filterSelected(type: FilterButtonType, filter: String) {
        switch type {
        case .camera:
            homeViewModel.cameraType = filter
            homeNavigationBar.cameraButton.filterLabel.text = filter
            homeNavigationBar.cameraLabel.text = filter
        
        case .roverType:
            homeViewModel.roverType = filter
            homeNavigationBar.roverButton.filterLabel.text = filter
        }
        
        homeViewModel.filterArray()
        homeCollectionView.reloadData()
        scrollToTop()
    }
}

extension HomeViewController: DatePickerDelegate {
    func didSelectDate(longDate: String, shortDate: String) {
        clearData()
        callAllNetworkMethods()
        resetParameters()
        self.homeViewModel.shortDate = shortDate
        self.homeNavigationBar.dateLabel.text = longDate
        self.homeViewModel.shortDate = shortDate
    }
    
    func clearData() {
        ImageCache.shared.clearCache()
        self.homeViewModel.currentPage = 1
        self.homeCollectionView.reloadData()
    }
    
    func resetParameters() {
        self.homeViewModel.roverType = "All"
        self.homeViewModel.cameraType = "All"
        self.homeNavigationBar.roverButton.filterLabel.text = "All"
        self.homeNavigationBar.cameraButton.filterLabel.text = "All"
        self.homeNavigationBar.cameraLabel.text = "All"
    }
}
