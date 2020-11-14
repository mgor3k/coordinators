//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit

class Trailing: HStack {
    init(_ item: StackItem) {
        super.init {
            UIView()
            item.view
        }
    }
}
