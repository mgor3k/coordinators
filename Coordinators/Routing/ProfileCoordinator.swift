//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit
import Store

class ProfileCoordinator: Coordinator {
    private let navigationController: NavigationController
    var children: [Coordinator] = []
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let store = ProfileStore(delegate: self)
        let vc = ProfileViewController(store: store)
        navigationController.viewControllers = [vc]
    }
}

extension ProfileCoordinator: ProfileDelegate {
    func willShowSettings() {
        let nav = NavigationController()
        let coordinator = SettingsCoordinator(
            navigationController: nav,
            delegate: self
        )
        coordinator.start()
        attach(coordinator)
        navigationController.present(nav, animated: true)
    }
}

extension ProfileCoordinator: SettingsCoordinatorDelegate {
    func didClose(_ coordinator: SettingsCoordinator) {
        detach(coordinator)
    }
}
