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
    
    // TODO: Fix
    @Published public var error: Error?
    
    private weak var delegate: LoginDelegate?
    private var subscriptions: Set<AnyCancellable> = []
    
    // TODO: Pass networking
    public init(delegate: LoginDelegate) {
        self.delegate = delegate
        setupBindings()
    }
    
    public func authenticate() {
        isLoading = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.isLoading = false
            DispatchQueue.main.async {
                if self?.username.lowercased() == "error" {
                    self?.error = Login.Error.invalidLogin
                } else {
                    self?.delegate?.didLogin()
                }
            }
        }
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
