//
//  Created by Maciej Gorecki on 03/11/2020.
//

import Foundation

public struct HomeModel: Identifiable, Hashable {
    public let id = UUID()
    public let title: String
    public let isBought: Bool
    
    public init(title: String, isBought: Bool) {
        self.title = title
        self.isBought = isBought
    }
}
