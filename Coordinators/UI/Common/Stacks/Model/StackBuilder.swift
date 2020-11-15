//
//  Created by Maciej Gorecki on 14/11/2020.
//

import Foundation

@_functionBuilder
struct StackBuilder {
    static func buildBlock(_ views: StackItem...) -> [StackItem] {
        views
    }
}
