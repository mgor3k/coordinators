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
    
    private var stack: UIStackView!
    
    private let viewModel: LoginViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    private var isKeyboardShowed = false
    
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
        stack = VStack([
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
        loginButton.addAction { [weak self] _ in
            self?.view.endEditing(true)
            self?.viewModel.authenticate()
        }
        
        forgotButton.addAction { [weak viewModel] _ in
            viewModel?.forgotPassword()
        }
        
        signupButton.addAction { [weak viewModel] _ in
            viewModel?.signup()
        }
    }
    
    func setupBindings() {
        setupViewModelBindings()
        setupKeyboardBindings()
    }
    
    func setupViewModelBindings() {
        viewModel.$isLoading
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoading, on: loginButton)
            .store(in: &subscriptions)
        
        viewModel.$isValid
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &subscriptions)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.showError(error)
            }
            .store(in: &subscriptions)
        
        username.textPublisher
            .assign(to: \.username, on: viewModel)
            .store(in: &subscriptions)
        
        password.textPublisher
            .assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}

// MARK: - Keyboard
private extension LoginViewController {
    func setupKeyboardBindings() {
        UIResponder.keyboardWillShowPublisher()
            .sink { [weak self] keyboardRect in
                guard let self = self, !self.isKeyboardShowed else { return }
                self.adjustView(to: keyboardRect.origin.y)
                self.isKeyboardShowed = true
            }
            .store(in: &subscriptions)
        
        UIResponder.keyboardWillHidePublisher()
            .sink { [weak self] _ in
                self?.adjustView(to: .zero)
                self?.isKeyboardShowed = false
            }
            .store(in: &subscriptions)
    }
    
    func adjustView(to keyboardOriginY: CGFloat) {
        guard keyboardOriginY != .zero else {
            moveStack(offset: .zero)
            return
        }
        
        let viewEnd = signupButton.convert(signupButton.frame, to: view).origin.y
        let remaining = 32 - (viewEnd - keyboardOriginY)
        
        if remaining > 0 {
            moveStack(offset: -remaining)
        }
    }
    
    func moveStack(offset: CGFloat) {
        stack.snp.updateConstraints {
            $0.centerY.equalToSuperview().offset(offset)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}