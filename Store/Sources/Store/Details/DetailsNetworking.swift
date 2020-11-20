//
//  Created by Maciej Gorecki on 15/11/2020.
//

import Combine

public protocol DetailsNetworking {
    /// Buy the item
    func markAsBought(_ model: HomeModel) -> AnyPublisher<Void, Error>
}
