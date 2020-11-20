//
//  Created by Maciej Gorecki on 09/11/2020.
//

import UIKit
import Lottie

class AuthSuccessViewController: ViewController, Finishable {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let blurView = UIVisualEffectView(
        effect: UIBlurEffect(style: .dark)
    )
    
    private let animation: AnimationView = {
        let anim = AnimationView(name: "success")
        anim.contentMode = .scaleAspectFit
        anim.loopMode = .playOnce
        return anim
    }()
    
    var onFinished: (() -> Void)?
    
    override func setup() {
        view.backgroundColor = UIColor.clear
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animation.play { [weak self] _ in
            self?.onFinished?()
        }
    }
}

private extension AuthSuccessViewController {
    func setupLayout() {
        view.addSubview(blurView)
        view.addSubview(containerView)
        containerView.addSubview(animation)
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        animation.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
            $0.size.equalTo(CGSize(width: 150, height: 150))
        }
    }
}
