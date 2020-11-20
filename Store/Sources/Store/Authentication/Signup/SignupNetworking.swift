//
//  Created by Maciej Gorecki on 20/11/2020.
//

import Foundation
import Combine

public protocol SignupNetworking {
    /// Signup using username, email and password, returns a token
    /// - Parameters:
    ///   - username: user's username
    ///   - email: user's email address
    ///   - password: user's password
    func signup(
        username: String,
        email: String,
        password: String)
    -> AnyPublisher<String, Signup.Error>
}
