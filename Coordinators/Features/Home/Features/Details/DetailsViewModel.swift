//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

protocol DetailsDelegate: class {
    func didBuyModel(_ model: HomeModel)
}

class DetailsViewModel {
    private let model: HomeModel
    private weak var delegate: DetailsDelegate?
    
    var screenName: String {
        model.title
    }
    
    init(model: HomeModel, delegate: DetailsDelegate) {
        self.model = model
        self.delegate = delegate
    }
    
    func buy() {
        delegate?.didBuyModel(model)
    }
}
