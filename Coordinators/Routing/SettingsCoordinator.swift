//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation
import Store

protocol SettingsCoordinatorDelegate: class {
    func didClose(_ coordinator: SettingsCoordinator)
}

class SettingsCoordinator: Coordinator {
    private let navigationController: NavigationController
    private weak var delegate: SettingsCoordinatorDelegate?
    
    var children: [Coordinator] = []
    
    init(navigationController: NavigationController, delegate: SettingsCoordinatorDelegate) {
        self.navigationController = navigationController
        self.delegate = delegate
        
        navigationController.onDismiss = { [weak self] in
            self?.didClose()
        }
    }
    
    func start() {
        let store = SettingsStore(delegate: self)
        let vc = SettingsViewController(store: store)
        navigationController.barColor = .black
        navigationController.viewControllers = [vc]
    }
}

extension SettingsCoordinator: SettingsDelegate {
    func didSelectSettings(_ settings: Settings) {
//        print(option.title)
        
        navigationController.dismiss(animated: true)
        didClose()
    }
}

private extension SettingsCoordinator {
    func didClose() {
        delegate?.didClose(self)
    }
}
