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
        backgroundColor = UIColor(red: 0.98, green: 0.37, blue: 0.23, alpha: 1)
        layer.cornerRadius = 30
        titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        snp.makeConstraints {
            $0.height.equalTo(60)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
