//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class HStack: UIStackView {
    init(spacing: CGFloat = 0,
         @StackBuilder _ content: () -> [StackItem]) {
        super.init(frame: .zero)
        self.spacing = spacing
        
        let views = content()
        
        var prevView: UIView?
        for item in views {
            let view = item.view
            addArrangedSubview(view)
            if let spacing = item.spacing, let prevView = prevView {
                setCustomSpacing(spacing, after: prevView)
            }
            prevView = view
        }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
