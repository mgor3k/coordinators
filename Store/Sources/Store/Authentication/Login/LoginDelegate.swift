//
//  Created by Maciej Gorecki on 15/11/2020.
//

public protocol LoginDelegate: class {
    func didLogin()
    func navigate(to destination: Login.Navigation)
}
