//
//  Created by Maciej Gorecki on 15/11/2020.
//

import Foundation

public protocol HomeStoreNetworking {
    func fetchData() -> [HomeModel]
}
