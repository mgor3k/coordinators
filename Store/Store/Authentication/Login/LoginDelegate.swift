//
//  Created by Maciej Gorecki on 15/11/2020.
//

import Foundation

public protocol LoginDelegate: class {
    func didLogin()
    func willRememberPassword()
    func willSignup()
}
