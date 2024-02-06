import UIKit

extension UICollectionView {
    convenience init(delegate: UICollectionViewDelegate? = nil, dataSource: UICollectionViewDataSource? = nil ) {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .white
        self.delegate = delegate
        self.dataSource = dataSource
    }
}
