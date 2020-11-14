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
        navigationController.barColor = .black
        navigationController.viewControllers = [vc]
    }
}

extension ProfileCoordinator: ProfileDelegate {
    func didSelectOption(_ option: ProfileModel) {
        print(option.title)
        
        navigationController.dismiss(animated: true)
        didClose()
    }
}

private extension ProfileCoordinator {
    func didClose() {
        delegate?.didClose(self)
    }
}
