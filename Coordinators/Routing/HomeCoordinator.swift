//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit
import Store

class HomeCoordinator: Coordinator {
    private let navigationController: NavigationController
    private let factory: HomeFactory
    
    var children: [Coordinator] = []
    
    private var onBought: ((HomeModel) -> Void)?
    
    init(
        navigationController: NavigationController,
        factory: HomeFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let store = HomeStore(network: MockService.shared, delegate: self)
        let vc = factory.makeHome(store: store)
        
        onBought = { [weak store] model in
            store?.fetch()
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
        let store = DetailsStore(
            network: MockService.shared,
            model: model,
            delegate: self
        )
        let vc = factory.makeDetails(store: store)
        navigationController.show(vc, sender: self)
    }
    
    func showSuccess(for model: HomeModel) {
        let vc = factory.makeBuySuccess(name: model.title)
        navigationController.present(vc, animated: true) { [weak navigationController] in
            navigationController?.popToRootViewController(animated: false)
        }
    }
}
