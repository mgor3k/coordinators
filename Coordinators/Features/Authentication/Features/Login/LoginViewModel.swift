//
//  Created by Maciej Gorecki on 30/10/2020.
//

import Foundation
import Combine

protocol LoginDelegate: class {
    func didLogin()
    func willRememberPassword()
    func willSignup()
}

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    
    @Published var isLoading = false
    @Published var isValid = false
        
    let screenName = "Login"
    
    private weak var delegate: LoginDelegate?
    private var subscriptions: Set<AnyCancellable> = []
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
        setupBindings()
    }
    
    func authenticate() {
        isLoading = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.isLoading = false
            DispatchQueue.main.async {
                self?.delegate?.didLogin()
            }
        }
    }
    
    func forgotPassword() {
        delegate?.willRememberPassword()
    }
    
    func signup() {
        delegate?.willSignup()
    }
}

private extension LoginViewModel {
    func setupBindings() {
        Publishers.CombineLatest($username, $password)
            .map { !($0.0.isEmpty || $0.1.isEmpty) }
            .assign(to: \.isValid, on: self)
            .store(in: &subscriptions)
    }
}
