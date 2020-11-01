//
//  Created by Maciej Gorecki on 30/10/2020.
//

import Foundation

protocol Coordinator: class {
    var children: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func attach(_ coordinator: Coordinator) {
        children.append(coordinator)
    }
    
    func detach(_ coordinator: Coordinator) {
        if let index = children.firstIndex(where: { $0 === coordinator }) {
            children.remove(at: index)
        }
    }
}
