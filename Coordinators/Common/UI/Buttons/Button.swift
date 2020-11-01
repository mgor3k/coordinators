//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class Button: UIButton {
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha = self.isHighlighted ? 0.5 : 1
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() { }
    
    func addAction(_ action: @escaping UIActionHandler) {
        addAction(.init(handler: action), for: .touchUpInside)
    }
}
