//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class Centered: HStack {
    init(_ item: StackItem) {
        super.init([UIView(), item.view, UIView()])
        distribution = .equalCentering
    }
}
