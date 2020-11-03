//
//  Created by Maciej Gorecki on 03/11/2020.
//

import UIKit

enum HomeCompositionalLayout {
    static func create() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(100)
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )
        
        item.contentInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        return .init(section: section)
    }
}
