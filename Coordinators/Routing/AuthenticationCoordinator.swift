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
    private let factory: AuthFactory
    private weak var delegate: AuthenticationCoordinatorDelegate?

    var children: [Coordinator] = []
    
    init(
        navigationController: UINavigationController,
        factory: AuthFactory,
        delegate: AuthenticationCoordinatorDelegate) {
        self.navigationController = navigationController
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        showLogin()
    }
}

private extension AuthenticationCoordinator {
    func showLogin() {
        let store = LoginStore(network: MockService.shared, delegate: self)
        let vc = factory.makeLogin(store: store)
        navigationController.show(vc, sender: self)
    }
    
    func showForgotPassword() {
        let vc = factory.makeRemindPassword()
        navigationController.show(vc, sender: self)
    }
    
    func showSignup() {
        let store = SignupStore(network: MockService.shared, delegate: self)
        let vc = factory.makeSignup(store: store)
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
    func didSignup(with token: String) {
        let vc = factory.makeAuthSuccess()
        vc.onFinished = { [weak self] in
            self?.finish()
        }
        navigationController.present(vc, animated: true)
    }
    
    private func finish() {
        delegate?.didAuthenticate(self)
    }
}
