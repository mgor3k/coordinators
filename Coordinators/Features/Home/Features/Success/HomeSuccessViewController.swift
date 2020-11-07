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
    
    private let viewModel: HomeSuccessViewModel
    
    init(viewModel: HomeSuccessViewModel) {
        self.viewModel = viewModel
        super.init()
        
        titleLabel.text = viewModel.title
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
