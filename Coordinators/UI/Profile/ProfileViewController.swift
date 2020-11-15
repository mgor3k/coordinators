//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit
import Store

class ProfileViewController: ViewController {
    private let store: ProfileStore
    
    init(store: ProfileStore) {
        self.store = store
        super.init()
    }
    
    override func setup() {
        view.backgroundColor = .yellow
        title = "Profile"
        let action = UIAction { [weak store] _ in
            store?.showSettings()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", primaryAction: action)
    }
}
