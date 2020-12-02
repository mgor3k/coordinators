//
//  Created by Maciej Gorecki on 02/12/2020.
//

import Store

extension Settings {
    var title: String {
        switch self {
        case .thing:
            return "Thing"
        case .otherThing:
            return "Other thing"
        case .secondThing:
            return "Second thing"
        }
    }
    
    var isToggle: Bool {
        switch self {
        case .thing:
            return true
        default:
            return false
        }
    }
}
