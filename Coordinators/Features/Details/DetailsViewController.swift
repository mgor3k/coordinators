//
//  Created by Maciej Gorecki on 06/11/2020.
//

import UIKit

class DetailsViewController: ViewController {
    private let viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        view.backgroundColor = .white
        title = viewModel.screenName
    }
}
