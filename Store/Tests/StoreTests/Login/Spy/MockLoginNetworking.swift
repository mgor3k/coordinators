//
//  Created by Maciej Gorecki on 20/11/2020.
//

import Combine
import Store

struct MockLoginNetworking: LoginNetworking {
    let token: String?
    let error: Login.Error?
    
    func authenticate(username: String, password: String) -> AnyPublisher<String, Login.Error> {
        Future { promise in
            if let error = self.error {
                promise(.failure(error))
            } else {
                promise(.success(self.token ?? ""))
            }
        }
        .eraseToAnyPublisher()
    }
}
