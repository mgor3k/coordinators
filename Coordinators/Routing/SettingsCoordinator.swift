//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit
import Store

class SettingsCoordinator: Coordinator {
    private let navigationController: NavigationController
    var children: [Coordinator] = []
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let store = SettingsStore(delegate: self)
        let vc = SettingsViewController(store: store)
        navigationController.viewControllers = [vc]
    }
}

extension SettingsCoordinator: SettingsDelegate {
    func willShowProfile() {
        let nav = NavigationController()
        let coordinator = ProfileCoordinator(
            navigationController: nav,
            delegate: self
        )
        coordinator.start()
        attach(coordinator)
        navigationController.present(nav, animated: true)
    }
}

extension SettingsCoordinator: ProfileCoordinatorDelegate {
    func didClose(_ coordinator: ProfileCoordinator) {
        detach(coordinator)
    }
}
