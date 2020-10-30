//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

protocol StackItem {
    var view: UIView { get }
    var spacing: CGFloat? { get }
}

struct Spaced: StackItem {
    let view: UIView
    let spacing: CGFloat?
    
    init(_ view: UIView, _ spacing: CGFloat? = nil) {
        self.view = view
        self.spacing = spacing
    }
}

extension UIView: StackItem {
    var view: UIView { self }
    var spacing: CGFloat? { nil }
}
