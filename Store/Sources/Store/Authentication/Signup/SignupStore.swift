//
//  Created by Maciej Gorecki on 08/11/2020.
//

import Combine
import Foundation

public class SignupStore: ObservableObject {
    @Published public var name = ""
    @Published public var lastName = ""
    @Published public var email = ""
    
    @Published public var isLoading = false
    @Published public var isValid = false
    
    private var subscriptions: Set<AnyCancellable> = []
    private weak var delegate: SignupDelegate?
    
    // TODO: Pass networking
    public init(delegate: SignupDelegate) {
        self.delegate = delegate
        setupBindings()
    }
    
    public func signup() {
        isLoading = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isLoading = false
            DispatchQueue.main.async {
                self?.delegate?.didSignup()
            }
        }
    }
}

private extension SignupStore {
    func setupBindings() {
        Publishers.CombineLatest3($name, $lastName, $email)
            .map { !($0.0.isEmpty || $0.1.isEmpty || $0.2.isEmpty) }
            .assign(to: \.isValid, on: self)
            .store(in: &subscriptions)
    }
}
