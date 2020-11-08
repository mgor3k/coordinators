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
        btn.addAction { [weak self] _ in
            self?.signup()
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
        
        // TODO: Make this better, move to viewModel
        Publishers.CombineLatest3(
            nameTextField.textPublisher,
            lastNameTextField.textPublisher,
            emailTextField.textPublisher)
            .map { !($0.0.isEmpty || $0.1.isEmpty || $0.2.isEmpty) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: signupButton)
            .store(in: &subscriptions)
    }
    
    func signup() {
        let model = SignupModel(
            name: nameTextField.text ?? "",
            lastName: lastNameTextField.text ?? "",
            email: emailTextField.text ?? ""
        )
        viewModel.signup(model)
    }
}
