//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private var isLoggedIn = true
    
    var children: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        isLoggedIn ? showMain() : showAuthentication()
    }
}

private extension AppCoordinator {
    func showAuthentication() {
        let nav = NavigationController()
        let coordinator = AuthenticationCoordinator(
            navigationController: nav,
            delegate: self
        )
        coordinator.start()
        attach(coordinator)
        window.replaceRoot(nav)
    }
    
    func showMain() {
        let tabBar = TabBarController()
        
        let coordinators: [Coordinator] = [
            HomeCoordinator(
                tabBarController: tabBar
            ),
            SettingsCoordinator(
                tabBarController: tabBar
            )
        ]
        
        coordinators.forEach {
            $0.start()
            attach($0)
        }
        
        window.replaceRoot(tabBar)
    }
}

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func didAuthenticate(_ coordinator: Coordinator) {
        detach(coordinator)
        showMain()
    }
}
