//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit
import SnapKit

class LoginViewController: ViewController {
    private let username: TextField = {
        TextField(placeholder: "Username")
    }()
    
    private let password: TextField = {
        let tf = TextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let btn = Button()
        btn.setTitle("Login", for: .normal)
        btn.addAction(.init(handler: { [weak self] _ in
            self?.loginButtonTapped()
        }), for: .touchUpInside)
        return btn
    }()
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        title = "Login"
        view.backgroundColor = UIColor(red: 0.16, green: 0.21, blue: 0.58, alpha: 1)
        setupLayout()
    }
}

private extension LoginViewController {
    func setupLayout() {
        let stack = VStack([
            username,
            password,
            Spaced(Centered(loginButton), 32)
        ], spacing: 16)
        
        view.addSubview(stack)
        
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(300)
        }
        
        loginButton.snp.makeConstraints {
            $0.width.equalToSuperview().dividedBy(2)
        }
    }
    
    func loginButtonTapped() {
        viewModel.authenticate(username: username.text ?? "", password: password.text ?? "")
    }
}
