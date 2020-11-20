//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit
import Store

protocol AuthenticationCoordinatorDelegate: class {
    func didAuthenticate(_ coordinator: Coordinator)
}

class AuthenticationCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private weak var delegate: AuthenticationCoordinatorDelegate?

    var children: [Coordinator] = []
    
    init(navigationController: UINavigationController, delegate: AuthenticationCoordinatorDelegate) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    func start() {
        showLogin()
    }
}

private extension AuthenticationCoordinator {
    func showLogin() {
        let store = LoginStore(network: MockService.shared, delegate: self)
        let vc = LoginViewController(store: store)
        navigationController.show(vc, sender: self)
    }
    
    func showForgotPassword() {
        let vc = PasswordReminderViewController()
        navigationController.show(vc, sender: self)
    }
    
    func showSignup() {
        let store = SignupStore(delegate: self)
        let vc = SignupViewController(store: store)
        navigationController.show(vc, sender: self)
    }
}

extension AuthenticationCoordinator: LoginDelegate {
    func didAuthenticate(with token: String) {
        delegate?.didAuthenticate(self)
    }
    
    func navigate(to destination: Login.Navigation) {
        switch destination {
        case .remindPassword:
            showForgotPassword()
        case .signup:
            showSignup()
        }
    }
}

extension AuthenticationCoordinator: SignupDelegate {
    func didSignup() {
        let vc = AuthSuccessViewController()
        vc.onFinished = { [weak self] in
            self?.finish()
        }
        navigationController.present(vc, animated: true)
    }
    
    private func finish() {
        delegate?.didAuthenticate(self)
    }
}
