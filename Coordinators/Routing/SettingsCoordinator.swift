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
    private let factory: ProfileFactory
    private weak var delegate: SettingsCoordinatorDelegate?
    
    var children: [Coordinator] = []
    
    init(
        navigationController: NavigationController,
        factory: ProfileFactory,
        delegate: SettingsCoordinatorDelegate) {
        self.navigationController = navigationController
        self.factory = factory
        self.delegate = delegate
        
        navigationController.onDismiss = { [weak self] in
            self?.didClose()
        }
    }
    
    func start() {
        let store = SettingsStore(
            userDefaults: UserDefaults.standard,
            delegate: self
        )
        let vc = factory.makeSettings(store: store)
        navigationController.barColor = .black
        navigationController.viewControllers = [vc]
    }
}

extension SettingsCoordinator: SettingsDelegate {
    func didSelectSettings(_ settings: Settings) {
        navigationController.dismiss(animated: true)
        didClose()
    }
}

private extension SettingsCoordinator {
    func didClose() {
        delegate?.didClose(self)
    }
}
