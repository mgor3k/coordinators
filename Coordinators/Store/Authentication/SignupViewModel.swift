//
//  Created by Maciej Gorecki on 08/11/2020.
//

import Combine
import Foundation

protocol SignupDelegate: class {
    func didSignup()
}

class SignupViewModel: ObservableObject {
    @Published var name = ""
    @Published var lastName = ""
    @Published var email = ""
    
    @Published var isLoading = false
    @Published var isValid = false
    
    var screenName = "Hello...!"
    
    private var subscriptions: Set<AnyCancellable> = []
    private weak var delegate: SignupDelegate?
    
    init(delegate: SignupDelegate) {
        self.delegate = delegate
        setupBindings()
    }
    
    func signup() {
        isLoading = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isLoading = false
            DispatchQueue.main.async {
                self?.delegate?.didSignup()
            }
        }
    }
}

private extension SignupViewModel {
    func setupBindings() {
        Publishers.CombineLatest3($name, $lastName, $email)
            .map { !($0.0.isEmpty || $0.1.isEmpty || $0.2.isEmpty) }
            .assign(to: \.isValid, on: self)
            .store(in: &subscriptions)
    }
}
