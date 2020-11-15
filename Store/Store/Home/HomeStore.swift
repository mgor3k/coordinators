//
//  Created by Maciej Gorecki on 03/11/2020.
//

import Foundation

public class HomeStore: ObservableObject {
    @Published public var models: [HomeModel] = []
    @Published public var isLoading = false
    
    private weak var delegate: HomeDelegate?
    private let network: HomeStoreNetworking
    
    public init(
        network: HomeStoreNetworking,
        delegate: HomeDelegate) {
        self.network = network
        self.delegate = delegate
        fetch(withDelay: 0.5)
    }
    
    // TODO: Change this
    public func didSelectModel(at index: Int) {
        let selectedModel = models[index]
        delegate?.didSelect(model: selectedModel)
    }
    
    public func fetch() {
        fetch(withDelay: 2)
    }
}

private extension HomeStore {
    func fetch(withDelay delay: TimeInterval) {
        isLoading = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.isLoading = false
            self?.models = self?.network.fetchData() ?? []
        }
    }
}
