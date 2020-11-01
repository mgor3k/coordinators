//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit

class InlineButton: Button {
    
    init(
        _ title: String? = nil,
        highlighted: String? = nil) {
        super.init()
        
        if let highlighted = highlighted, let title = title {
            let attr = NSMutableAttributedString(string: title)
            attr.append(NSAttributedString(string: highlighted, attributes: [
                .foregroundColor: UIColor(red: 0.98, green: 0.37, blue: 0.23, alpha: 1),
                .font: UIFont.systemFont(ofSize: 16, weight: .bold)
            ]))
            
            setAttributedTitle(attr, for: .normal)
        } else {
            setTitle(title, for: .normal)
        }
    }
    
    override func setup() {
        titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
        setTitleColor(.white, for: .normal)
    }
}
