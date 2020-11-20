//
//  Created by Maciej Gorecki on 20/11/2020.
//

import Foundation

public extension Signup {
    /// Signup error
    enum Error: LocalizedError {
        /// Username already exists
        case usernameAlreadyInUse
        
        public var errorDescription: String? {
            switch self {
            case .usernameAlreadyInUse:
                return "Username is already in use"
            }
        }
    }
}
