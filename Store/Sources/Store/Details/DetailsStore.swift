//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation
import Combine

public class DetailsStore: ObservableObject {
    /// Indicates if the request is being processed
    @Published public var isLoading = false
    
    /// Use to indicate if an error occured
    @Published public var error: Error?
    
    /// Model's name. Can be used as a title.
    public var name: String {
        model.title
    }

    private let model: HomeModel
    private let network: DetailsNetworking
    private weak var delegate: DetailsDelegate?
    private var subscriptions: Set<AnyCancellable> = []
    
    /// Initializer
    /// - Parameters:
    ///   - network: Pass your network service
    ///   - model: Pass the model for the details to be showed
    ///   - delegate: Pass your delegate to be nofified when the flow ends
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
    /// Buy the item
    /// Notify delegate when bought, error otherwise
    func buy() -> AnyPublisher<Void, Error> {
        isLoading = true
        
        let publisher = network
            .markAsBought(model)
        
        publisher
            .ignoreOutput()
            .sink(
                receiveCompletion: { [weak self] _ in self?.isLoading = false },
                receiveValue: { _ in })
            .store(in: &subscriptions)
        
        publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] status in
                    guard let self = self else { return }
                    switch status {
                    case .finished:
                        self.error = nil
                        self.delegate?.didBuyModel(self.model)
                    case .failure(let error):
                        self.error = error
                        break
                    }
                },
                receiveValue: { _ in })
            .store(in: &subscriptions)
        
        return publisher
    }
}
