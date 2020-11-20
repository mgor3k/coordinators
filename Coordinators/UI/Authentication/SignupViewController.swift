//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit
import Combine
import Store

class SignupViewController: ViewController {
    private let username = TextField(placeholder: "Username")
    private let email = TextField(placeholder: "Email")
    private let password = SecureTextField(placeholder: "Password")
    
    private let signupButton = LoadableRoundedButton("Signup")
    
    private let store: SignupStore
    private var subscriptions: Set<AnyCancellable> = []
    
    init(store: SignupStore) {
        self.store = store
        super.init()
    }
    
    override func setup() {
        view.backgroundColor = Colors.authBackground
        title = "Hello...!"
        
        setupLayout()
        setupActions()
        setupBindings()
    }
}

private extension SignupViewController {
    func setupLayout() {
        let stack = VStack(spacing: 16) {
            username
            email
            password
            Spaced(Centered(signupButton), 32)
        }
        
        view.addSubview(stack)
        stack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(48)
            $0.trailing.equalToSuperview().offset(-48)
        }
    }
    
    func setupActions() {
        signupButton.addAction { [weak self] _ in
            self?.store.signup()
            self?.view.endEditing(true)
        }
    }
    
    func setupBindings() {
        store.$isLoading
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoading, on: signupButton)
            .store(in: &subscriptions)
        
        store.$isValid
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: signupButton)
            .store(in: &subscriptions)
        
        username.textPublisher
            .assign(to: \.username, on: store)
            .store(in: &subscriptions)
        
        password.textPublisher
            .assign(to: \.password, on: store)
            .store(in: &subscriptions)
        
        email.textPublisher
            .assign(to: \.email, on: store)
            .store(in: &subscriptions)
    }
}
