//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private var isLoggedIn = false
    
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
        let factory = Factory()
        let tabBar = TabBarController()
        
        let home = factory.makeHome()
        let settings = factory.makeSettings()
        
        [home, settings].forEach {
            attach($0.coordinator)
            $0.coordinator.start()
            tabBar.addVC($0.navigation)
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
