//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class HomeCoordinator: Coordinator {
    private let tabBarController: TabBarController
    var children: [Coordinator] = []
    
    init(tabBarController: TabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let nav = NavigationController()
        let vc = HomeViewController()
        nav.title = vc.title
        nav.viewControllers = [vc]
        tabBarController.addVC(nav)
    }
}
