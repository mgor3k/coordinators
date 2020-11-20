//
//  Created by Maciej Gorecki on 30/10/2020.
//

import Foundation
import Combine

public class LoginStore: ObservableObject {
    @Published public var username = ""
    @Published public var password = ""
    
    @Published public var isLoading = false
    @Published public var isValid = false
    
    @Published public var error: Login.Error?
    
    private let network: LoginNetworking
    private weak var delegate: LoginDelegate?
    private var subscriptions: Set<AnyCancellable> = []
    
    public init(network: LoginNetworking, delegate: LoginDelegate) {
        self.network = network
        self.delegate = delegate
        setupBindings()
    }
    
    public func authenticate() {
        guard isValid else {
            error = .missingInput
            return
        }
        
        isLoading = true
        
        let publisher = network
            .authenticate(username: username, password: password)
            .share()
        
        publisher
            .ignoreOutput()
            .sink(
                receiveCompletion: { [weak self] _ in self?.isLoading = false },
                receiveValue: { _ in })
            .store(in: &subscriptions)
        
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] status in
                if case let .failure(error) = status {
                    self?.error = error
                } else {
                    self?.error = nil
                }
            }, receiveValue: { [weak delegate] token in
                delegate?.didAuthenticate(with: token)
            })
            .store(in: &subscriptions)
    }
    
    public func navigate(to destination: Login.Navigation) {
        delegate?.navigate(to: destination)
    }
}

private extension LoginStore {
    func setupBindings() {
        Publishers.CombineLatest($username, $password)
            .map { !($0.0.isEmpty || $0.1.isEmpty) }
            .assign(to: \.isValid, on: self)
            .store(in: &subscriptions)
    }
}
