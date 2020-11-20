//
//  Created by Maciej Gorecki on 20/11/2020.
//

import Combine

public protocol LoginNetworking {
    /// Authenticate using username and password, returns a token
    /// - Parameters:
    ///   - username: user's username
    ///   - password: user's password
    func authenticate(username: String, password: String) -> AnyPublisher<String, Login.Error>
}
