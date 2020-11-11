//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

protocol ProfileDelegate: class {}

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
}
