//
//  Created by Maciej Gorecki on 20/11/2020.
//

import XCTest
@testable import Store

class LoginDelegateSpy: LoginDelegate {
    var didAuthenticateExp: XCTestExpectation?
    
    var tokenReceived = ""
    var navigationHistory: [Login.Navigation] = []
    
    func didAuthenticate(with token: String) {
        tokenReceived = token
        didAuthenticateExp?.fulfill()
    }
    
    func navigate(to destination: Login.Navigation) {
        navigationHistory.append(destination)
    }
}
