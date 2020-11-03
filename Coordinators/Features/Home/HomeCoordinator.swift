//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class HomeCoordinator: Coordinator {
    private let tabBarController: TabBarController
    private let navigationController = NavigationController()
    var children: [Coordinator] = []
    
    init(tabBarController: TabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let vm = HomeViewModel()
        let vc = HomeViewController(viewModel: vm)
        navigationController.title = vc.title
        navigationController.barColor = .black
        navigationController.viewControllers = [vc]
        tabBarController.addVC(navigationController)
    }
}
