//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

protocol ProfileCoordinatorDelegate: class {
    func didClose(_ coordinator: ProfileCoordinator)
}

class ProfileCoordinator: Coordinator {
    private let navigationController: NavigationController
    private weak var delegate: ProfileCoordinatorDelegate?
    
    var children: [Coordinator] = []
    
    init(navigationController: NavigationController, delegate: ProfileCoordinatorDelegate) {
        self.navigationController = navigationController
        self.delegate = delegate
        
        navigationController.onDismiss = { [weak self] in
            self?.didClose()
        }
    }
    
    func start() {
        let vm = ProfileViewModel(delegate: self)
        let vc = ProfileViewController(viewModel: vm)
        navigationController.viewControllers = [vc]
    }
}

extension ProfileCoordinator: ProfileDelegate {
    func didClose() {
        delegate?.didClose(self)
    }
}
