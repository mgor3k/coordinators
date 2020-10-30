//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator {
    private let navigationController: UINavigationController
    private var children: [Coordinator] = []
    
    private var isLoggedIn = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        isLoggedIn ? showHome() : showAuthentication()
    }
}

private extension AppCoordinator {
    func showAuthentication() {
        let coordinator = AuthenticationCoordinator(
            navigationController: navigationController
        )
        coordinator.start()
        children.append(coordinator)
    }
    
    func showHome() {
        let coordinator = HomeCoordinator(
            navigationController: navigationController
        )
        coordinator.start()
        children.append(coordinator)
    }
}
