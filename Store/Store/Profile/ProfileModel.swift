//
//  Created by Maciej Gorecki on 11/11/2020.
//

import Foundation

public struct ProfileModel: Hashable {
    public let name: String
}

public struct ProfileGroup: Hashable {
    public let name: String
    public let profiles: [ProfileModel]
}
