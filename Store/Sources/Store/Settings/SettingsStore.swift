//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

public class SettingsStore {
    private weak var delegate: SettingsDelegate?
        
    public let models: [SettingsGroup]
    
    public init(delegate: SettingsDelegate) {
        self.delegate = delegate
        
        models = [
            SettingsGroup(name: "General", Settings: [
                Settings(name: "Thing"),
                Settings(name: "Second thing")
            ]),
            SettingsGroup(name: "Security", Settings: [
                Settings(name: "One thing")
            ])
        ]
    }
    
    public func selectSettings(_ settings: Settings) {
        delegate?.didSelectSettings(settings)
    }
}
