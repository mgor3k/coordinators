//
//  Created by Maciej Gorecki on 07/11/2020.
//

import UIKit

class HomeSuccessViewController: ViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
        
    init(name: String) {
        super.init()
        
        titleLabel.text = "Thanks for buying " + name
    }
    
    override func setup() {
        view.backgroundColor = .purple
        setupLayout()
    }
}

private extension HomeSuccessViewController {
    func setupLayout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
