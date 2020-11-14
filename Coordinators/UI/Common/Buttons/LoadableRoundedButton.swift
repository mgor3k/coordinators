//
//  Created by Maciej Gorecki on 01/11/2020.
//

import UIKit

class LoadableRoundedButton: RoundedButton {
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        return indicator
    }()
    
    private var originalText: String?
    
    var isLoading = false {
        didSet {
            isLoading ? startLoading() : stopLoading()
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
    
    override func setup() {
        super.setup()
        addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

private extension LoadableRoundedButton {
    func startLoading() {
        originalText = titleLabel?.text
        setTitle("", for: .normal)
        indicator.startAnimating()
    }
    
    func stopLoading() {
        setTitle(originalText, for: .normal)
        originalText = nil
        indicator.stopAnimating()
    }
}
