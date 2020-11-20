//
//  Created by Maciej Gorecki on 20/11/2020.
//

@testable import Store

class LoginDelegateSpy: LoginDelegate {
    var tokenReceived = ""
    var navigationHistory: [Login.Navigation] = []
    
    func didAuthenticate(with token: String) {
        tokenReceived = token
    }
    
    func navigate(to destination: Login.Navigation) {
        navigationHistory.append(destination)
    }
}
