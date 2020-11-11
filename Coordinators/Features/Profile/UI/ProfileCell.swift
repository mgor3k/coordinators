//
//  Created by Maciej Gorecki on 11/11/2020.
//

import UIKit

class ProfileCell: CollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    override func setup() {
        contentView.backgroundColor = .white
        setupLayout()
    }
}

private extension ProfileCell {
    func setupLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
