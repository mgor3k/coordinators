//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

protocol ProfileDelegate: class {}

class ProfileViewModel {
    private weak var delegate: ProfileDelegate?
    
    init(delegate: ProfileDelegate) {
        self.delegate = delegate
    }
}
