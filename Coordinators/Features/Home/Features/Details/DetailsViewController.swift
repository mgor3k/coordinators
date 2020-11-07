//
//  Created by Maciej Gorecki on 06/11/2020.
//

import UIKit

class DetailsViewController: ViewController {
    private lazy var button: RoundedButton = {
        let btn = RoundedButton("Buy")
        btn.addAction { [weak viewModel] _ in
            viewModel?.buy()
        }
        return btn
    }()
    
    private let viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        view.backgroundColor = .white
        title = viewModel.screenName
        
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
