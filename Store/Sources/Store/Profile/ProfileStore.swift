//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

public class ProfileStore {
    private weak var delegate: ProfileDelegate?
    
    public init(delegate: ProfileDelegate) {
        self.delegate = delegate
    }
}

public extension ProfileStore {
    func showSettings() {
        delegate?.willShowSettings()
    }
}
