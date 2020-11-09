//
//  Created by Maciej Gorecki on 09/11/2020.
//

import UIKit

class AuthSuccessViewController: ViewController {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let blurView = UIVisualEffectView(
        effect: UIBlurEffect(style: .dark)
    )
    
    override func setup() {
        view.backgroundColor = UIColor.clear
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        
        setupLayout()
    }
}

private extension AuthSuccessViewController {
    func setupLayout() {
        view.addSubview(blurView)
        view.addSubview(containerView)
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 200, height: 100))
            $0.center.equalToSuperview()
        }
    }
}
