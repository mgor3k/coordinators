//
//  Created by Maciej Gorecki on 06/11/2020.
//

import UIKit
import Combine
import Store

class DetailsViewController: ViewController {
    private lazy var button: LoadableRoundedButton = {
        let btn = LoadableRoundedButton("Buy")
        btn.addAction { [weak store] _ in
            store?.buy()
        }
        return btn
    }()
    
    private let store: DetailsStore
    private var subscriptions: Set<AnyCancellable> = []
    
    init(store: DetailsStore) {
        self.store = store
        super.init()
    }
    
    override func setup() {
        view.backgroundColor = .white
        title = store.name
        
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
        store.$isLoading
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoading, on: button)
            .store(in: &subscriptions)
    }
}
