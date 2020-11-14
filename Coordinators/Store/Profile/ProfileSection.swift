//
//  Created by Maciej Gorecki on 11/11/2020.
//

import Foundation

enum ProfileSection: CaseIterable {
    case general
    case security
    
    var title: String {
        switch self {
        case .general:
            return "General"
        case .security:
            return "Security"
        }
    }
}
