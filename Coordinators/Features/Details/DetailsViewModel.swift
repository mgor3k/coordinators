//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

class DetailsViewModel {
    private let model: HomeModel
    
    var screenName: String {
        model.title
    }
    
    init(model: HomeModel) {
        self.model = model
    }
}
