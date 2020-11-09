//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit
import Combine

class SignupViewController: ViewController {
    private let nameTextField = TextField(placeholder: "Name")
    private let lastNameTextField = TextField(placeholder: "Last Name")
    private let emailTextField = TextField(placeholder: "Email")
    
    private let signupButton = LoadableRoundedButton("Signup")
    
    private let viewModel: SignupViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        view.backgroundColor = Colors.authBackground
        title = viewModel.screenName
        
        setupLayout()
        setupActions()
        setupBindings()
    }
}

private extension SignupViewController {
    func setupLayout() {
        let stack = VStack([
            nameTextField,
            lastNameTextField,
            emailTextField,
            Spaced(Centered(signupButton), 32)
        ], spacing: 16)
        
        view.addSubview(stack)
        stack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(48)
            $0.trailing.equalToSuperview().offset(-48)
        }
    }
    
    func setupActions() {
        signupButton.addAction { [weak self] _ in
            self?.viewModel.signup()
            self?.view.endEditing(true)
        }
    }
    
    func setupBindings() {
        viewModel.$isLoading
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoading, on: signupButton)
            .store(in: &subscriptions)
        
        viewModel.$isValid
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: signupButton)
            .store(in: &subscriptions)
        
        nameTextField.textPublisher
            .assign(to: \.name, on: viewModel)
            .store(in: &subscriptions)
        
        lastNameTextField.textPublisher
            .assign(to: \.lastName, on: viewModel)
            .store(in: &subscriptions)
        
        emailTextField.textPublisher
            .assign(to: \.email, on: viewModel)
            .store(in: &subscriptions)
    }
}
