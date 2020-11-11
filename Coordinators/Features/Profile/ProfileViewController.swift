//
//  Created by Maciej Gorecki on 07/11/2020.
//

import UIKit

typealias ProfileDataSource = UICollectionViewDiffableDataSource<ProfileSection, ProfileModel>
typealias ProfileSnapshot = NSDiffableDataSourceSnapshot<ProfileSection, ProfileModel>

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
    
    private let viewModel: ProfileViewModel
    private lazy var dataSource = makeDataSource()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        title = viewModel.screenName
        view.backgroundColor = .lightGray
        setupLayout()
        setupCollectionView()
        applySnapshot()
    }
}

private extension ProfileViewController {
    func makeDataSource() -> ProfileDataSource {
        let ds = ProfileDataSource(collectionView: collectionView) { cv, indexPath, model in
            let cell = cv.dequeue(ProfileCell.self, for: indexPath)
            cell.setTitle(model.title)
            return cell
        }
        
        ds.supplementaryViewProvider = { cv, kind, indexPath in
            let header = cv.dequeueSupplementary(ProfileHeader.self, ofKind: kind, for: indexPath)
            header.setTitle(ProfileSection.allCases[indexPath.section].title)
            return header
        }
        
        return ds
    }
    
    func applySnapshot() {
        var snapshot = ProfileSnapshot()
        let sections = viewModel.models.map { $0.0 }
        snapshot.appendSections(sections)
        
        for section in viewModel.models {
            snapshot.appendItems(section.1, toSection: section.0)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func setupCollectionView() {
        collectionView.dataSource = makeDataSource()
        collectionView.register(ProfileCell.self)
        collectionView.registerHeader(ProfileHeader.self)
    }
    
    func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
