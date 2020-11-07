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
        let vm = HomeViewModel(delegate: self)
        let vc = HomeViewController(viewModel: vm)
        navigationController.configure(title: vc.title)
        navigationController.viewControllers = [vc]
        tabBarController.addVC(navigationController)
    }
}

extension HomeCoordinator: HomeDelegate {
    func didSelect(model: HomeModel) {
        showDetails(model: model)
    }
}

private extension HomeCoordinator {
    func showDetails(model: HomeModel) {
        let vm = DetailsViewModel(model: model)
        let vc = DetailsViewController(viewModel: vm)
        navigationController.show(vc, sender: self)
    }
}

private extension NavigationController {
    func configure(title: String?) {
        self.title = title
        tabBarItem.image = UIImage(systemName: "house")
        tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        barColor = .black
    }
}
