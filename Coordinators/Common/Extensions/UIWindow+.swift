//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit

extension UIWindow {
    func replaceRoot(_ root: UIViewController) {
        rootViewController = root
        UIView.transition(
            with: self,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
}
