//
//  Created by Maciej Gorecki on 20/11/2020.
//

import XCTest
import Store

class SignupDelegateSpy: SignupDelegate {
    var didSignupExp: XCTestExpectation?
    var tokenReceived = ""
    
    func didSignup(with token: String) {
        tokenReceived = token
        didSignupExp?.fulfill()
    }
}
