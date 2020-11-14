//
//  Created by Maciej Gorecki on 03/11/2020.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func dequeue<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T ?? T()
    }
    
    func registerHeader<T: UICollectionReusableView>(_ type: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: Self.elementKindSectionHeader,
            withReuseIdentifier: String(describing: T.self)
        )
    }
    
    func dequeueSupplementary<T: UICollectionReusableView>(
        _ type: T.Type,
        ofKind kind: String,
        for indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: T.self),
            for: indexPath) as? T ?? T()
    }
}
