//
//  Created by Maciej Gorecki on 03/11/2020.
//

import UIKit

class HomeCell: CollectionViewCell {
    private let titleLabel = UILabel()
    
    func setTitle(
        _ title: String,
        backgroundColor: UIColor = .white) {
        titleLabel.text = title
        contentView.backgroundColor = backgroundColor
    }
    
    override func setup() {
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        contentView.layer.cornerRadius = 10
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = .init(width: 0, height: 0)
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.1

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(
                UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
            )
        }
    }
}
