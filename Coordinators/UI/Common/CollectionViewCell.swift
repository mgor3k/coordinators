//
//  Created by Maciej Gorecki on 03/11/2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() { }
}
