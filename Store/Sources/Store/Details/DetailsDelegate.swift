//
//  Created by Maciej Gorecki on 20/11/2020.
//

public protocol DetailsDelegate: class {
    /// Notify when the model was successfully bought
    func didBuyModel(_ model: HomeModel)
}
