//
//  Created by Maciej Gorecki on 06/11/2020.
//

import UIKit
import Combine

class DetailsViewController: ViewController {
    private lazy var button: LoadableRoundedButton = {
        let btn = LoadableRoundedButton("Buy")
        btn.addAction { [weak viewModel] _ in
            viewModel?.buy()
        }
        return btn
    }()
    
    private let viewModel: DetailsViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        view.backgroundColor = .white
        title = viewModel.screenName
        
        setupLayout()
        setupBindings()
    }
}

private extension DetailsViewController {
    func setupLayout() {
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setupBindings() {
        viewModel.$isLoading
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoading, on: button)
            .store(in: &subscriptions)
    }
}
