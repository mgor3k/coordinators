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
    private weak var delegate: LoginDelegate?
    
    let screenName = "Login"
    
    @Published var isLoading = false
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
    }
    
    func authenticate(username: String, password: String) {
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
