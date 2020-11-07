//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class SettingsCoordinator: Coordinator {
    private let tabBarController: TabBarController
    private let navigationController = NavigationController()
    var children: [Coordinator] = []
    
    init(tabBarController: TabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let vm = SettingsViewModel(delegate: self)
        let vc = SettingsViewController(viewModel: vm)
        navigationController.configure(title: vc.title)
        navigationController.viewControllers = [vc]
        
        // TODO: Fix this
        tabBarController.addVC(navigationController)
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

private extension NavigationController {
    func configure(title: String?) {
        self.title = title
        tabBarItem.image = UIImage(systemName: "gearshape")
        tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        barColor = .black
    }
}
