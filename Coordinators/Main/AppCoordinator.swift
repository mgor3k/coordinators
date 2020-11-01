//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class AppCoordinator: Coordinator {
    private let navigationController: NavigationController
    private var isLoggedIn = false
    
    var children: [Coordinator] = []
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        isLoggedIn ? showMain() : showAuthentication()
    }
}

private extension AppCoordinator {
    func showAuthentication() {
        let coordinator = AuthenticationCoordinator(
            navigationController: navigationController,
            delegate: self
        )
        coordinator.start()
        attach(coordinator)
    }
    
    func showMain() {
        let coordinator = HomeCoordinator(
            navigationController: navigationController
        )
        coordinator.start()
        attach(coordinator)
    }
}

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func didAuthenticate(_ coordinator: Coordinator) {
        detach(coordinator)
        navigationController.clearViewControllers()
        showMain()
    }
}
