//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

class HomeSuccessViewModel {
    private let model: HomeModel
    
    var title: String {
        "Thanks for buying " + model.title
    }
    
    init(model: HomeModel) {
        self.model = model
    }
}
