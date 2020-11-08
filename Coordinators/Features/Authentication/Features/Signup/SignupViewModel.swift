//
//  Created by Maciej Gorecki on 08/11/2020.
//

import Foundation

class SignupViewModel: ObservableObject {
    
    @Published var isLoading = false
    
    func signup(_ model: SignupModel) {
        isLoading = true
    }
}
