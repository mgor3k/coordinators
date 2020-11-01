//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

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
        let viewModel = LoginViewModel()
        viewModel.delegate = self
        let vc = LoginViewController(viewModel: viewModel)
        navigationController.show(vc, sender: self)
    }
}

extension AuthenticationCoordinator: LoginDelegate {
    func didLogin() {
        delegate?.didAuthenticate(self)
    }
}
