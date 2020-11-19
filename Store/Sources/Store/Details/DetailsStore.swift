//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

public protocol DetailsDelegate: class {
    func didBuyModel(_ model: HomeModel)
}

public class DetailsStore: ObservableObject {
    @Published public var isLoading = false

    private let model: HomeModel
    private let network: DetailsNetworking
    private weak var delegate: DetailsDelegate?
    
    public var name: String {
        model.title
    }
    
    public init(
        network: DetailsNetworking,
        model: HomeModel,
        delegate: DetailsDelegate) {
        self.network = network
        self.model = model
        self.delegate = delegate
    }
}

public extension DetailsStore {
    func buy() {
        isLoading = true
        
        let model = self.model
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.isLoading = true
            self?.network.markAsBought(model)
            
            DispatchQueue.main.async {
                self?.delegate?.didBuyModel(model)
            }
        }
    }
}
