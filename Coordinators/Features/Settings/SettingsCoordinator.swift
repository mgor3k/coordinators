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
        let vc = SettingsViewController()
        navigationController.configure(title: vc.title)
        navigationController.viewControllers = [vc]
        tabBarController.addVC(navigationController)
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
