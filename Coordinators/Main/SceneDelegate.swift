//
//  SceneDelegate.swift
//  Coordinators
//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.windowScene = windowScene
        
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
}

