//
//  Created by Maciej Gorecki on 02/12/2020.
//

import UIKit

class Switch: UISwitch {
    var onToggled: ((Bool) -> Void)?
    
    init(isOn: Bool) {
        super.init(frame: .zero)
        self.isOn = isOn
        setupActions()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension Switch {
    func setupActions() {
        let action = UIAction { [weak self] action in
            if let isOn = self?.isOn {
                self?.onToggled?(isOn)
            }
        }
        addAction(action, for: .valueChanged)
    }
}
