//
//  Created by Maciej Gorecki on 11/11/2020.
//

import Foundation

public struct Settings: Hashable {
    public let name: String
}

public struct SettingsGroup: Hashable {
    public let name: String
    public let Settings: [Settings]
}
