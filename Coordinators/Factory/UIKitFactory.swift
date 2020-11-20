//
//  Created by Maciej Gorecki on 20/11/2020.
//

import UIKit
import Store

struct UIKitFactory: ViewFactory {
    func makeLogin(store: LoginStore) -> UIViewController {
        LoginViewController(store: store)
    }
    
    func makeSignup(store: SignupStore) -> UIViewController {
        SignupViewController(store: store)
    }
    
    func makeRemindPassword() -> UIViewController {
        PasswordReminderViewController()
    }
    
    func makeAuthSuccess() -> UIViewController & Finishable {
        AuthSuccessViewController()
    }
}
