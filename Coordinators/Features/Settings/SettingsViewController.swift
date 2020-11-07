//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit

class SettingsViewController: ViewController {
    private let viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        view.backgroundColor = .yellow
        title = "Settings"
        let action = UIAction { [weak viewModel] _ in
            viewModel?.showProfile()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", primaryAction: action)
    }
}
