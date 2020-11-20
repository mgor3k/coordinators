//
//  Created by Maciej Gorecki on 07/11/2020.
//

import UIKit
import Store

protocol ViewFactory {
    func makeLogin(store: LoginStore) -> UIViewController
    func makeSignup(store: SignupStore) -> UIViewController
    func makeRemindPassword() -> UIViewController
    func makeAuthSuccess() -> UIViewController & Finishable
}
