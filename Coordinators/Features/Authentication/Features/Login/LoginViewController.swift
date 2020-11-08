//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit
import SnapKit
import Combine

class LoginViewController: ViewController {
    private let username = TextField(placeholder: "Username")
    private let password = SecureTextField(placeholder: "Password")
    
    private let loginButton = LoadableRoundedButton("Login")
    private let forgotButton = InlineButton("Forgot password?")
    private let signupButton = InlineButton("New user? ", highlighted: "Signup")
    
    private let viewModel: LoginViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        title = viewModel.screenName
        view.backgroundColor = Colors.authBackground
        setupLayout()
        setupActions()
        setupBindings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
}

private extension LoginViewController {
    func setupLayout() {
        let stack = VStack([
            username,
            password,
            Trailing(forgotButton),
            Spaced(Centered(loginButton), 32),
            Centered(signupButton)
        ], spacing: 16)
        
        view.addSubview(stack)
        
        stack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(48)
            $0.trailing.equalToSuperview().offset(-48)
        }
    }
    
    func setupActions() {
        loginButton.addAction { [weak viewModel] _ in
            viewModel?.authenticate()
        }
        
        forgotButton.addAction { [weak viewModel] _ in
            viewModel?.forgotPassword()
        }
        
        signupButton.addAction { [weak viewModel] _ in
            viewModel?.signup()
        }
    }
    
    func setupBindings() {
        viewModel.$isLoading
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoading, on: loginButton)
            .store(in: &subscriptions)
        
        viewModel.$isValid
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &subscriptions)
        
        username.textPublisher
            .assign(to: \.username, on: viewModel)
            .store(in: &subscriptions)
        
        password.textPublisher
            .assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
    }
}
