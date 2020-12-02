//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

public class SettingsStore {
    private weak var delegate: SettingsDelegate?
    private let userDefaults: UserDefaults
    
    public let models: [SettingsGroup]
    
    public init(userDefaults: UserDefaults, delegate: SettingsDelegate) {
        self.userDefaults = userDefaults
        self.delegate = delegate
        
        models = [
            SettingsGroup(name: "General", Settings: [
                .thing,
                .secondThing
            ]),
            SettingsGroup(name: "Security", Settings: [
                .otherThing
            ])
        ]
    }
    
    public func selectSettings(_ settings: Settings) {
        delegate?.didSelectSettings(settings)
    }
    
    public func toggleSettings(_ settings: Settings, isOn: Bool) {
        userDefaults.setValue(isOn, forKey: settings.rawValue)
    }
    
    public func isSettingToggled(_ setting: Settings) -> Bool {
        userDefaults.bool(forKey: setting.rawValue)
    }
}
