//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit
import SnapKit

class LoginViewController: ViewController {
    private let username = TextField(placeholder: "Username")
    private let password = SecureTextField(placeholder: "Password")
    
    private let loginButton = RoundedButton("Login")
    private let forgotButton = InlineButton("Forgot password?")
    private let signupButton = InlineButton("New user? ", highlighted: "Signup")
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        title = viewModel.screenName
        view.backgroundColor = UIColor(red: 0.16, green: 0.21, blue: 0.58, alpha: 1)
        setupLayout()
        setupActions()
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
        loginButton.addAction { [unowned self] _ in
            self.viewModel.authenticate(
                username: self.username.text ?? "",
                password: self.password.text ?? ""
            )
        }
        
        forgotButton.addAction { [unowned viewModel] _ in
            viewModel.forgotPassword()
        }
        
        signupButton.addAction { [unowned viewModel] _ in
            viewModel.signup()
        }
    }
}
