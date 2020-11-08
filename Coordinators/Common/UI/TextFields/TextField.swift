//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class TextField: UITextField {
    private enum Constants {
        static let leadingInset: CGFloat = 16
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: Constants.leadingInset, y: 0, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: Constants.leadingInset, y: 0, width: bounds.width, height: bounds.height)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: Constants.leadingInset, y: 0, width: bounds.width, height: bounds.height)
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        backgroundColor = UIColor.white.withAlphaComponent(0.3)
        layer.cornerRadius = 25
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor: UIColor.white.withAlphaComponent(0.5),
        ])
        
        font = .systemFont(ofSize: 18, weight: .bold)
        textColor = .white
        tintColor = .white
        delegate = self
        
        snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
