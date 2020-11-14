//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

protocol ProfileDelegate: class {
    func didSelectOption(_ option: ProfileModel)
}

class ProfileViewModel {
    private weak var delegate: ProfileDelegate?
    
    let screenName = "Profile"
    
    var models: [(ProfileSection, [ProfileModel])] = [
        (.general, [
            .thing
        ]),
        (.security, [
            .otherThing,
            .lastThing
        ])
    ]
    
    init(delegate: ProfileDelegate) {
        self.delegate = delegate
    }
    
    func select(atIndexPath indexPath: IndexPath) {
        delegate?.didSelectOption(
            models[indexPath.section].1[indexPath.item]
        )
    }
}
