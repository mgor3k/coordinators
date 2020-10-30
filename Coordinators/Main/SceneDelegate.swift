//
//  SceneDelegate.swift
//  Coordinators
//
//  Created by Maciej Gorecki on 30/10/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.windowScene = windowScene
        
        let navigationController = NavigationController()
        window?.rootViewController = navigationController
        
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        
        window?.makeKeyAndVisible()
    }
}

