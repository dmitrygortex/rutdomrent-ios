//
//  SceneDelegate.swift
//  RutApp
//
//  Created by Michael Kivo on 14/01/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let vc = LoginViewController()
        let navController = UINavigationController(rootViewController: vc)
        
        window.rootViewController = navController
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }

}

