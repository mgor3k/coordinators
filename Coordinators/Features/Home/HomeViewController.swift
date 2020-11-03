//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit
import Combine

typealias HomeSnapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeModel>
typealias HomeDataSource = UICollectionViewDiffableDataSource<HomeSection, HomeModel>

class HomeViewController: ViewController {
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: HomeCompositionalLayout.create()
        )
        cv.backgroundColor = .white
        return cv
    }()
    
    private let indicator = UIActivityIndicatorView(style: .large)
    
    private let viewModel: HomeViewModel
    private lazy var dataSource = makeDataSource()
    private var subscriptions: Set<AnyCancellable> = []
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        view.backgroundColor = .white
        title = viewModel.screenName
        
        setupCollectionView()
        setupIndicator()
        setupBindings()
    }
}

private extension HomeViewController {
    func setupCollectionView() {
        collectionView.dataSource = dataSource
        collectionView.register(HomeCell.self)
        applySnapshot(animatingDifferences: false)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupIndicator() {
        view.addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setupBindings() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                $0 ? self?.indicator.startAnimating() : self?.indicator.stopAnimating()
            })
            .store(in: &subscriptions)
        
        viewModel.$models
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.applySnapshot()
            })
            .store(in: &subscriptions)
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
