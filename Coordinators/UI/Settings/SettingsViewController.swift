//
//  Created by Maciej Gorecki on 07/11/2020.
//

import UIKit
import Store

typealias SettingsDataSource = UICollectionViewDiffableDataSource<SettingsGroup, Settings>
typealias SettingsSnapshot = NSDiffableDataSourceSnapshot<SettingsGroup, Settings>

class SettingsViewController: ViewController {
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: SettingsCompositionalLayout.create()
        )
        cv.backgroundColor = .clear
        cv.alwaysBounceVertical = false
        cv.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        return cv
    }()
    
    private let store: SettingsStore
    private lazy var dataSource = makeDataSource()
    
    init(store: SettingsStore) {
        self.store = store
        super.init()
    }
    
    override func setup() {
        title = "Settings"
        view.backgroundColor = .lightGray
        setupLayout()
        setupCollectionView()
        applySnapshot()
    }
}

private extension SettingsViewController {
    func makeDataSource() -> SettingsDataSource {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Settings> { cell, indexPath, model in
            var content = cell.defaultContentConfiguration()
            content.text = model.name
            cell.contentConfiguration = content
        }
        
        let ds = SettingsDataSource(collectionView: collectionView) { cv, indexPath, model in
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
        var snapshot = SettingsSnapshot()
        let sections = store.models
        snapshot.appendSections(sections)
        
        for section in store.models {
            snapshot.appendItems(section.Settings, toSection: section)
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

extension SettingsViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
        let settings = store.models[indexPath.section].Settings[indexPath.item]
        store.selectSettings(settings)
    }
}
