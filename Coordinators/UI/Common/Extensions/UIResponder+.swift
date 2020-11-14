//
//  Created by Maciej Gorecki on 08/11/2020.
//

import UIKit
import Combine

extension UIResponder {
    static func keyboardWillShowPublisher() -> AnyPublisher<CGRect, Never> {
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect }
            .eraseToAnyPublisher()
    }
    
    static func keyboardWillHidePublisher() -> AnyPublisher<CGRect, Never> {
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .compactMap { $0.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect }
            .eraseToAnyPublisher()
    }
}
