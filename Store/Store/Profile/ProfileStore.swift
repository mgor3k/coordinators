//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

public class ProfileStore {
    private weak var delegate: ProfileDelegate?
        
    public let models: [ProfileGroup]
    
    public init(delegate: ProfileDelegate) {
        self.delegate = delegate
        
        models = [
            ProfileGroup(name: "General", profiles: [
                ProfileModel(name: "Thing"),
                ProfileModel(name: "Second thing")
            ]),
            ProfileGroup(name: "Security", profiles: [
                ProfileModel(name: "One thing")
            ])
        ]
    }
    
    public func selectOption(_ option: ProfileModel) {
        delegate?.didSelectOption(option)
    }
}
