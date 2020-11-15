//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit
import Store

class SettingsViewController: ViewController {
    private let store: SettingsStore
    
    init(store: SettingsStore) {
        self.store = store
        super.init()
    }
    
    override func setup() {
        view.backgroundColor = .yellow
        title = "Settings"
        let action = UIAction { [weak store] _ in
            store?.showProfile()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", primaryAction: action)
    }
}
