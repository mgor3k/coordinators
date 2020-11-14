//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

protocol SettingsDelegate: class {
    func willShowProfile()
}

class SettingsViewModel {
    private weak var delegate: SettingsDelegate?
    
    init(delegate: SettingsDelegate) {
        self.delegate = delegate
    }
    
    func showProfile() {
        delegate?.willShowProfile()
    }
}
