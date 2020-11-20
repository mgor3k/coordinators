//
//  Created by Maciej Gorecki on 20/11/2020.
//

import Combine
import Store

class MockLoginNetworking: LoginNetworking {
    var token: String?
    var error: Login.Error?
    var callCount = 0
    
    func authenticate(
        username: String,
        password: String)
    -> AnyPublisher<String, Login.Error> {
        
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
