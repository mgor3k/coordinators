//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class HomeCoordinator: Coordinator {
    private let navigationController: NavigationController
    var children: [Coordinator] = []
    
    private var onBought: ((HomeModel) -> Void)?
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = HomeViewModel(delegate: self)
        let vc = HomeViewController(viewModel: vm)
        
        onBought = { [weak vm] model in
            vm?.fetch()
        }
        
        navigationController.viewControllers = [vc]
    }
}

extension HomeCoordinator: HomeDelegate {
    func didSelect(model: HomeModel) {
        showDetails(model: model)
    }
}

extension HomeCoordinator: DetailsDelegate {
    func didBuyModel(_ model: HomeModel) {
        onBought?(model)
        showSuccess(for: model)
    }
}

private extension HomeCoordinator {
    func showDetails(model: HomeModel) {
        let vm = DetailsViewModel(
            model: model,
            delegate: self
        )
        let vc = DetailsViewController(viewModel: vm)
        navigationController.show(vc, sender: self)
    }
    
    func showSuccess(for model: HomeModel) {
        let vm = HomeSuccessViewModel(model: model)
        let vc = HomeSuccessViewController(viewModel: vm)
        navigationController.present(vc, animated: true) { [weak navigationController] in
            navigationController?.popToRootViewController(animated: false)
        }
    }
}
