//
//  Created by Maciej Gorecki on 15/11/2020.
//

public protocol LoginDelegate: class {
    /// Called when authenticated
    func didAuthenticate(with token: String)
    
    /// Move to other authentication related screen
    func navigate(to destination: Login.Navigation)
}
