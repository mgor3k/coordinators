//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit
import Combine

class SignupViewController: ViewController {
    private let nameTextField = TextField(placeholder: "Name")
    private let lastNameTextField = TextField(placeholder: "Last Name")
    private let emailTextField = TextField(placeholder: "Email")
    
    private lazy var signupButton: LoadableRoundedButton = {
        let btn = LoadableRoundedButton("Signup")
        btn.addAction { [weak viewModel] _ in
            viewModel?.signup()
        }
        btn.isEnabled = false
        return btn
    }()
    
    private let viewModel: SignupViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setup() {
        // TODO: Move colors
        view.backgroundColor = UIColor(red: 0.16, green: 0.21, blue: 0.58, alpha: 1)
        title = "Hello...!"
        
        setupLayout()
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
    
    func setupBindings() {
        viewModel.$isLoading
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoading, on: signupButton)
            .store(in: &subscriptions)
        
        viewModel.$isValid
            .dropFirst()
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
