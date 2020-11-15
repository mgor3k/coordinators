//
//  Created by Maciej Gorecki on 07/11/2020.
//

import UIKit
import Store

typealias ProfileDataSource = UICollectionViewDiffableDataSource<ProfileGroup, ProfileModel>
typealias ProfileSnapshot = NSDiffableDataSourceSnapshot<ProfileGroup, ProfileModel>

class ProfileViewController: ViewController {
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: ProfileCompositionalLayout.create()
        )
        cv.backgroundColor = .clear
        cv.alwaysBounceVertical = false
        cv.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        return cv
    }()
    
    private let store: ProfileStore
    private lazy var dataSource = makeDataSource()
    
    init(store: ProfileStore) {
        self.store = store
        super.init()
    }
    
    override func setup() {
        title = "Profile"
        view.backgroundColor = .lightGray
        setupLayout()
        setupCollectionView()
        applySnapshot()
    }
}

private extension ProfileViewController {
    func makeDataSource() -> ProfileDataSource {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, ProfileModel> { cell, indexPath, model in
            var content = cell.defaultContentConfiguration()
            content.text = model.name
            cell.contentConfiguration = content
        }
        
        let ds = ProfileDataSource(collectionView: collectionView) { cv, indexPath, model in
            cv.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: model)
        }
        
        ds.supplementaryViewProvider = { [weak store] cv, kind, indexPath in
            let header = cv.dequeueSupplementary(UICollectionViewListCell.self, ofKind: kind, for: indexPath)
            var content = header.defaultContentConfiguration()
            content.text = store?.models[indexPath.section].name
            header.contentConfiguration = content
            return header
        }
        
        return ds
    }
    
    func applySnapshot() {
        var snapshot = ProfileSnapshot()
        let sections = store.models
        snapshot.appendSections(sections)
        
        for section in store.models {
            snapshot.appendItems(section.profiles, toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func setupCollectionView() {
        collectionView.dataSource = makeDataSource()
        collectionView.delegate = self
        collectionView.registerHeader(UICollectionViewListCell.self)
    }
    
    func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
        let option = store.models[indexPath.section].profiles[indexPath.item]
        store.selectOption(option)
    }
}
