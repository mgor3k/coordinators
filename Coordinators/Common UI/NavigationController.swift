//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class NavigationController: UINavigationController {
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
