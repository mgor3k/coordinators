//
//  Created by Maciej Gorecki on 20/11/2020.
//

protocol Finishable: class {
    var onFinished: (() -> Void)? { get set }
}
