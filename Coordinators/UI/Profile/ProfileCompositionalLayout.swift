//
//  Created by Maciej Gorecki on 11/11/2020.
//

import UIKit

class ProfileCompositionalLayout {
    static func create() -> UICollectionViewCompositionalLayout {
        .init { _, environment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            configuration.headerMode = .supplementary
            let section = NSCollectionLayoutSection.list(
                using: configuration, layoutEnvironment: environment
            )
            return section
        }
    }
}
