//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit

class TabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addVC(_ vc: UIViewController) {
        if viewControllers != nil {
            viewControllers?.append(vc)
        } else {
            viewControllers = [vc]
        }
    }
}
