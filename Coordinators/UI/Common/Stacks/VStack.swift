//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class VStack: HStack {
    override init(
        spacing: CGFloat = 0,
        @StackBuilder _ content: () -> [StackItem]) {
        super.init(spacing: spacing, content)
        axis = .vertical
    }
}
