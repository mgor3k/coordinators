//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit

class TabBarController: UITabBarController {
    init(_ viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        setViewControllers(viewControllers, animated: false)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
