//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit

class RoundedButton: Button {
    init(_ title: String? = nil) {
        super.init()
        
        setTitle(title, for: .normal)
    }
    
    override func setup() {
        backgroundColor = UIColor(red: 0.98, green: 0.37, blue: 0.23, alpha: 1)
        layer.cornerRadius = 30
        titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        contentEdgeInsets = .init(top: 0, left: 42, bottom: 0, right: 42)
        
        snp.makeConstraints {
            $0.height.equalTo(60)
        }
    }
}
