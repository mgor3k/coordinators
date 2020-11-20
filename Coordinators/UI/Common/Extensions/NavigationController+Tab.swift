//
//  Created by Maciej Gorecki on 20/11/2020.
//

import UIKit

extension NavigationController {
    convenience init(title: String?, imageName: String) {
        self.init()
        self.title = title
        tabBarItem.image = UIImage(systemName: imageName)
        tabBarItem.selectedImage = UIImage(systemName: "\(imageName).fill")
        barColor = .black
    }
}
