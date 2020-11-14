//
//  Created by Maciej Gorecki on 11/11/2020.
//

import Foundation

enum ProfileModel: Hashable {
    case thing, otherThing, lastThing
    
    var title: String {
        switch self {
        case .thing:
            return "Thing"
        case .otherThing:
            return "Other Thing"
        case .lastThing:
            return "Last Thing"
        }
    }
}
