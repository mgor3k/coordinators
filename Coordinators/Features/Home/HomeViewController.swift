//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

typealias HomeSnapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeModel>
typealias HomeDataSource = UICollectionViewDiffableDataSource<HomeSection, HomeModel>

class HomeViewController: ViewController {
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: HomeCompositionalLayout.create()
        )
        return cv
    }()
    
    private let viewModel: HomeViewModel
    private lazy var dataSource = makeDataSource()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        view.backgroundColor = .white
        title = viewModel.screenName
        
        setupCollectionView()
    }
}

private extension HomeViewController {
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.dataSource = dataSource
        collectionView.register(HomeCell.self)
        applySnapshot(animatingDifferences: false)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func makeDataSource() -> HomeDataSource {
        HomeDataSource(
            collectionView: collectionView) { cv, indexPath, model in
            let cell = cv.dequeue(HomeCell.self, for: indexPath)
            cell.setTitle(model.title)
            return cell
        }
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = HomeSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.models)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
