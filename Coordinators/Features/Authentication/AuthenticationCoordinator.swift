//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class AuthenticationCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLogin()
    }
}

private extension AuthenticationCoordinator {
    func showLogin() {
        let vc = LoginViewController()
        navigationController.show(vc, sender: self)
    }
}
