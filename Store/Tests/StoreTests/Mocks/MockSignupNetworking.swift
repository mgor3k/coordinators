//
//  Created by Maciej Gorecki on 20/11/2020.
//

import Combine
import Store

class MockSignupNetworking: SignupNetworking {
    var token: String?
    var error: Signup.Error?
    var callCount = 0
    
    func signup(
        username: String,
        email: String,
        password: String)
    -> AnyPublisher<String, Signup.Error> {
        
        Future { promise in
            self.callCount += 1
            
            if let error = self.error {
                promise(.failure(error))
            } else {
                promise(.success(self.token ?? ""))
            }
        }
        .eraseToAnyPublisher()
    }
}
