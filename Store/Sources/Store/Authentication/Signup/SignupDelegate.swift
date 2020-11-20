//
//  Created by Maciej Gorecki on 15/11/2020.
//

import Foundation

public protocol SignupDelegate: class {
    /// Called when successfully signed
    func didSignup(with token: String)
}
