//
//  Created by Maciej Gorecki on 30/10/2020.
//

import Foundation

protocol LoginDelegate: class {
    func didLogin()
    func willRememberPassword()
    func willSignup()
}

class LoginViewModel {
    weak var delegate: LoginDelegate?
    
    let screenName = "Login"
    
    func authenticate(username: String, password: String) {
        // TODO: Simulate request + combine
        delegate?.didLogin()
    }
    
    func forgotPassword() {
        delegate?.willRememberPassword()
    }
    
    func signup() {
        delegate?.willSignup()
    }
}
