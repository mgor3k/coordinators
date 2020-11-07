//
//  Created by Maciej Gorecki on 03/11/2020.
//

import UIKit

class HomeCell: CollectionViewCell {
    private let titleLabel = UILabel()
    private let boughtImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "purchased.circle.fill"))
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        return iv
    }()
    
    func setTitle(
        _ title: String,
        isBought: Bool,
        backgroundColor: UIColor = .white) {
        titleLabel.text = title
        boughtImageView.isHidden = !isBought
        contentView.backgroundColor = backgroundColor
    }
    
    override func setup() {
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        contentView.layer.cornerRadius = 10
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = .init(width: 0, height: 0)
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.1
        
        let stack = HStack([titleLabel, UIView(), boughtImageView])
        contentView.addSubview(stack)
        stack.snp.makeConstraints {
            $0.edges.equalTo(
                UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
            )
        }
        
        boughtImageView.snp.makeConstraints {
            $0.width.equalTo(32)
        }
    }
}
