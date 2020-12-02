//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class NavigationController: UINavigationController {
    var barColor: UIColor = .white {
        didSet { setBarColor(barColor) }
    }
    
    var onDismiss: (() -> Void)?
    
    init(barColor: UIColor = .black) {
        self.barColor = barColor
        super.init(nibName: nil, bundle: nil)
        setBarColor(barColor)
        navigationBar.prefersLargeTitles = true
        presentationController?.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clearViewControllers() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .fade
        view.layer.add(transition, forKey: nil)
        viewControllers = []
    }
}

private extension NavigationController {
    func setBarColor(_ color: UIColor) {
        navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: barColor
        ]
    }
}

extension NavigationController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(
        _ presentationController: UIPresentationController) {
        onDismiss?()
    }
}
