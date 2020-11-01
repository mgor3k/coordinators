//
//  Created by Maciej Gorecki on 30/10/2020.
//

import Foundation

protocol LoginDelegate: class {
    func didLogin()
}

class LoginViewModel {
    weak var delegate: LoginDelegate?
    
    let screenName = "Login"
    
    func authenticate(username: String, password: String) {
        // TODO: Simulate request + combine
        delegate?.didLogin()
    }
}
