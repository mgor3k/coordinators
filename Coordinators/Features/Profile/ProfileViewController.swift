//
//  Created by Maciej Gorecki on 07/11/2020.
//

import UIKit

class ProfileViewController: ViewController {
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        view.backgroundColor = .brown
        title = "Profile"
    }
}
