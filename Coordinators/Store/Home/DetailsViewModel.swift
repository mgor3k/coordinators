//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

protocol DetailsDelegate: class {
    func didBuyModel(_ model: HomeModel)
}

class DetailsViewModel: ObservableObject {
    private let model: HomeModel
    private weak var delegate: DetailsDelegate?
    
    @Published var isLoading = false
    
    var screenName: String {
        model.title
    }
    
    init(model: HomeModel, delegate: DetailsDelegate) {
        self.model = model
        self.delegate = delegate
    }
    
    func buy() {
        isLoading = true
        
        let model = self.model
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.isLoading = true
            MockService.shared.currentState = .bought(model)
            
            DispatchQueue.main.async {
                self?.delegate?.didBuyModel(model)
            }
        }
    }
}
