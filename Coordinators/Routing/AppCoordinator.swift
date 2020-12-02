//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let factory: ViewFactory
    private var isLoggedIn = false
    
    var children: [Coordinator] = []
    
    init(window: UIWindow, factory: ViewFactory) {
        self.window = window
        self.factory = factory
    }
    
    func start() {
        isLoggedIn ? showMain() : showAuthentication()
    }
}

private extension AppCoordinator {
    func showAuthentication() {
        let nav = NavigationController(barColor: .white)
        let coordinator = AuthenticationCoordinator(
            navigationController: nav,
            factory: factory,
            delegate: self
        )
        coordinator.start()
        attach(coordinator)
        window.replaceRoot(nav)
    }
    
    func showMain() {
        let homeNav = NavigationController(
            title: "Home",
            imageName: "house"
        )
        
        let profileNav = NavigationController(
            title: "Profile",
            imageName: "person.circle"
        )
        
        let home: Coordinator = HomeCoordinator(
            navigationController: homeNav,
            factory: factory
        )
        
        let profile: Coordinator = ProfileCoordinator(
            navigationController: profileNav,
            factory: factory
        )
                
        [home, profile].forEach {
            attach($0)
            $0.start()
        }
        
        window.replaceRoot(
            TabBarController([homeNav, profileNav])
        )
    }
}

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func didAuthenticate(_ coordinator: Coordinator) {
        detach(coordinator)
        showMain()
    }
}
