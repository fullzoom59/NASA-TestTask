import Foundation
import OrderedCollections

class HomeViewModel {
    private let networkManager: NetworkProvider
    private let urlRequestBuilder: URLRequestBuilder
    private let filterStrategy: FilterStrategy
    private let realmService = RealmService()
    public var allRovers = [Photo]()
    public var selectedCategory = [Photo]()
    
    public var isLoading = false
    public var currentPage = 1 {
        didSet {
            if currentPage == 1 {
                removeAllItems()
            }
        }
    }
    
    var roverType = "All"
    var cameraType = "All"
    var shortDate = "2019-6-6"
    var longDate = "June 6, 2019"
    
    init(networkManager: NetworkProvider, urlGenerator: URLRequestBuilder, filterStrategy: FilterStrategy) {
        self.networkManager = networkManager
        self.urlRequestBuilder = urlGenerator
        self.filterStrategy = filterStrategy
    }
    
    public func fetchInformation(
        roverType: RoverType,
        completion: @escaping (
            (Result<[Photo], Error>) -> Void
        )
    ) {
        guard let url = urlRequestBuilder.request(endpoint: roverType.endpoint, queryItems: [
            URLQueryItem(name: "page", value: "\(currentPage)"),
            URLQueryItem(name: "earth_date", value: shortDate)
        ]) else { return }
        
        isLoading = true
        networkManager.fetchData(generator: url) { (result: Result<NasaObject, Error>) in
            self.isLoading = false
            switch result {
            case .success(let success):
                let object = success.photos
                completion(.success(object))
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(.failure(failure))
            }
        }
    }
    
    private func removeAllItems() {
        allRovers.removeAll()
        selectedCategory.removeAll()
    }
    
    public func getAllRoversData() {
        selectedCategory = allRovers
    }
    
    public func filterArray() {
        selectedCategory = filterStrategy.filter(object: allRovers, rover: roverType, camera: cameraType)
    }
    
    public func getDateFromString() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: shortDate)
    }
    
    public func saveCurrentFilters(longDate: String) {
        let historyObject = HistoryObject()
        historyObject.camera = self.cameraType
        historyObject.rover = self.roverType
        historyObject.longDate = longDate
        historyObject.shortDate = self.shortDate
        realmService.saveToRealm(object: historyObject)
    }
    
    public func filterParametersForRover() -> FilterParameters {
        var roverNames = OrderedSet<String>(["All"])
        
        roverNames.append(contentsOf: allRovers.map { $0.rover?.name ?? "" })
        let filterParameters = FilterParameters(
            title: "Rover",
            dataSource: Array(OrderedSet(roverNames)),
            filterButton: .roverType,
            selectedFilter: roverType
        )
        return filterParameters
    }
    
    public func filterParametersForCamera() -> FilterParameters {
        var cameraNames = OrderedSet<String>(["All"])

        let object = allRovers.compactMap { $0.rover?.cameras }.flatMap { $0 }
        cameraNames.append(contentsOf: object.compactMap { $0.fullName })
        let filterParameters = FilterParameters(
            title: "Camera",
            dataSource: Array(OrderedSet(cameraNames)),
            filterButton: .camera,
            selectedFilter: cameraType
        )
        return filterParameters
    }
}
