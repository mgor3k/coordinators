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
}
