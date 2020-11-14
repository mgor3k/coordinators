//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit

class SecureTextField: TextField {
    override init(placeholder: String) {
        super.init(placeholder: placeholder)
        isSecureTextEntry = true
    }
}
