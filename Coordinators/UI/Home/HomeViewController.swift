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
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let indicator = UIActivityIndicatorView(style: .large)
    private lazy var refreshControl: UIRefreshControl = {
        let action = UIAction { [weak viewModel] _ in
            // Mock adding new data on refresh
            MockService.shared.currentState = .addNew
            viewModel?.fetch()
        }
        let rc = UIRefreshControl(frame: .zero, primaryAction: action)
        return rc
    }()
    
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
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
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
            .sink(receiveValue: { [weak self] isLoading in
                guard self?.refreshControl.isRefreshing == true else {
                    isLoading ? self?.indicator.startAnimating() : self?.indicator.stopAnimating()
                    return
                }
                
                // beginRefreshing is called automatically on pull
                if !isLoading {
                    self?.refreshControl.endRefreshing()
                }
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
            cell.setTitle(
                model.title,
                isBought: model.isBought,
                backgroundColor: colors[indexPath.item % colors.count]
            )
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

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectModel(at: indexPath.item)
    }
}

private let colors: [UIColor] = [
    UIColor(red: 1.00, green: 0.69, blue: 0.53, alpha: 1.00),
    UIColor(red: 1.00, green: 0.41, blue: 0.49, alpha: 1.00),
    UIColor(red: 0.79, green: 0.40, blue: 0.53, alpha: 1.00),
    UIColor(red: 0.46, green: 0.35, blue: 0.52, alpha: 1.00),
    UIColor(red: 0.15, green: 0.37, blue: 0.52, alpha: 1.00)
]
