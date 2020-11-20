//
//  Created by Maciej Gorecki on 30/10/2020.
//

import Foundation
import Combine

public class LoginStore: ObservableObject {
    /// Bind to username input
    @Published public var username = ""
    
    /// Bind to password input
    @Published public var password = ""
    
    /// Use to indicate user when authentication is in progress
    @Published public var isLoading = false
    
    /// Use to indicate user is all inputs are complete
    @Published public var isValid = false
    
    /// Use to indicate if an error occured
    @Published public var error: Login.Error?
    
    private let network: LoginNetworking
    private weak var delegate: LoginDelegate?
    private var subscriptions: Set<AnyCancellable> = []
    
    /// Initializer
    /// - Parameters:
    ///   - network: Pass your networking service with the login methods
    ///   - delegate: Pass your delegate that should handle the navigation
    public init(
        network: LoginNetworking,
        delegate: LoginDelegate) {
        self.network = network
        self.delegate = delegate
        setupBindings()
    }
}

public extension LoginStore {
    /// Authenticate using binded username + password
    func authenticate() {
        guard isValid else {
            error = .missingInput
            return
        }
        
        isLoading = true
        
        let publisher = network
            .authenticate(username: username, password: password)
        
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
    
    /// Navigate to different parts of the authentication
    func navigate(to destination: Login.Navigation) {
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
