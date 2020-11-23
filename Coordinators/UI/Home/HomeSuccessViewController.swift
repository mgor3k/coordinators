//
//  Created by Maciej Gorecki on 07/11/2020.
//

import UIKit
import Lottie

class HomeSuccessViewController: ViewController {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let button = AnimatedButton(animation: Animation.named("heart")!)
    
    init(name: String) {
        super.init()
        
        titleLabel.text = "Thanks for buying " + name
    }
    
    override func setup() {
        view.backgroundColor = .purple
        setupLayout()
        setupAnimationButton()
    }
}

private extension HomeSuccessViewController {
    func setupLayout() {
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(button)
        
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 250, height: 250))
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setupAnimationButton() {
        button.setPlayRange(
            fromMarker: "touchDownStart",
            toMarker: "touchDownEnd",
            event: .touchDown
        )
        
        button.setPlayRange(
            fromMarker: "touchDownEnd",
            toMarker: "touchUpCancel",
            event: .touchUpOutside
        )

        button.setPlayRange(
            fromMarker: "touchDownEnd",
            toMarker: "touchUpEnd",
            event: .touchUpInside
        )
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        button.isEnabled = false
    }
}
