//
//  Created by Maciej Gorecki on 03/11/2020.
//

import Foundation

struct HomeModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let isBought: Bool
}
