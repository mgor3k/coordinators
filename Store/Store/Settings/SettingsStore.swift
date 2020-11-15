//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

public class SettingsStore {
    private weak var delegate: SettingsDelegate?
    
    public init(delegate: SettingsDelegate) {
        self.delegate = delegate
    }
}

public extension SettingsStore {
    func showProfile() {
        delegate?.willShowProfile()
    }
}
