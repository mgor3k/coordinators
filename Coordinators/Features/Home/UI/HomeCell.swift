//
//  Created by Maciej Gorecki on 03/11/2020.
//

import UIKit

class HomeCell: CollectionViewCell {
    private let titleLabel = UILabel()
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    override func setup() {
        contentView.backgroundColor = .blue

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(
                UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
            )
        }
    }
}
