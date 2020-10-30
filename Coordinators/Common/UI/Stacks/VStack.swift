//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class VStack: HStack {
    override init(
        _ content: [StackItem],
        spacing: CGFloat = 0) {
        super.init(content, spacing: spacing)
        axis = .vertical
    }
}
