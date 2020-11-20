//
//  Created by Maciej Gorecki on 06/11/2020.
//

import UIKit
import Combine
import Store

class DetailsViewController: ViewController {
    private let button = LoadableRoundedButton("Buy")
    
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
        setupActions()
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
    
    func setupActions() {
        button.addAction { [weak self] _ in
            self?.buy()
        }
    }
    
    func buy() {
        store.buy()
            .ignoreOutput()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] in
                // Fix button returning from loading when presenting another view - looks ugly
                if case .finished = $0 {
                    self?.button.isHidden = true
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }
}
