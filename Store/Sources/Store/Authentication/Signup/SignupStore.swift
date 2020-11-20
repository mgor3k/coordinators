//
//  Created by Maciej Gorecki on 08/11/2020.
//

import Combine
import Foundation

public class SignupStore: ObservableObject {
    /// Bind to user's username input
    @Published public var username = ""
    
    /// Bind to user's email input
    @Published public var email = ""
    
    /// Bind to user's password input
    @Published public var password = ""
    
    /// Indicates if the request is being processed
    @Published public var isLoading = false
    
    /// Indicates if all the inputed fields are valid
    @Published public var isValid = false
    
    /// Use to indicate if an error occured
    @Published public var error: Signup.Error?
    
    private let network: SignupNetworking
    private var subscriptions: Set<AnyCancellable> = []
    private weak var delegate: SignupDelegate?
    
    /// Initialization
    /// - Parameters:
    ///   - network: Pass your networking service with the signup methods
    ///   - delegate: Pass your delegate that should handle the navigation
    public init(
        network: SignupNetworking,
        delegate: SignupDelegate) {
        self.network = network
        self.delegate = delegate
        setupBindings()
    }
}

public extension SignupStore {
    /// Signup using binded username + email + password
    func signup() {
        isLoading = true
        
        let publisher = network
            .signup(username: username, email: email, password: password)
        
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
                delegate?.didSignup(with: token)
            })
            .store(in: &subscriptions)
    }
}

private extension SignupStore {
    func setupBindings() {
        Publishers.CombineLatest3($username, $email, $password)
            .map { !($0.0.isEmpty || $0.1.isEmpty || $0.2.isEmpty) }
            .assign(to: \.isValid, on: self)
            .store(in: &subscriptions)
    }
}
