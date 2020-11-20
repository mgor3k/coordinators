//
//  Created by Maciej Gorecki on 15/11/2020.
//

import Foundation

public extension Login {
    /// Login error
    enum Error: LocalizedError {
        /// Username doesnt exist
        case invalidUsername
        
        public var errorDescription: String? {
            switch self {
            case .invalidUsername:
                return "Invalid username"
            }
        }
    }
}
