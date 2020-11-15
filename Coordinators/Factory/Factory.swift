//
//  Created by Maciej Gorecki on 07/11/2020.
//

import UIKit

typealias FactoryOutput = (coordinator: Coordinator, navigation: NavigationController)

struct Factory {
    func makeHome() -> FactoryOutput {
        let nav = NavigationController()
        nav.configure(title: "Home", imageName: "house")
        let home = HomeCoordinator(
            navigationController: nav
        )
        return (home, nav)
    }
    
    func makeProfile() -> FactoryOutput {
        let nav = NavigationController()
        nav.configure(title: "Profile", imageName: "person.circle")
        let Profile = ProfileCoordinator(
            navigationController: nav
        )
        return (Profile, nav)
    }
}

private extension NavigationController {
    func configure(title: String?, imageName: String) {
        self.title = title
        tabBarItem.image = UIImage(systemName: imageName)
        tabBarItem.selectedImage = UIImage(systemName: "\(imageName).fill")
        barColor = .black
    }
}
