//
//  Created by Maciej Gorecki on 07/11/2020.
//

import UIKit
import Store

typealias ViewFactory = AuthFactory & HomeFactory & ProfileFactory

protocol AuthFactory {
    func makeLogin(store: LoginStore) -> UIViewController
    func makeSignup(store: SignupStore) -> UIViewController
    func makeRemindPassword() -> UIViewController
    func makeAuthSuccess() -> UIViewController & Finishable
}

protocol HomeFactory {
    func makeHome(store: HomeStore) -> UIViewController
    func makeDetails(store: DetailsStore) -> UIViewController
    func makeBuySuccess(name: String) -> UIViewController
}

protocol ProfileFactory {
    func makeProfile(store: ProfileStore) -> UIViewController
    func makeSettings(store: SettingsStore) -> UIViewController
}
