//
//  SceneDelegate.swift
//  Password
//
//  Created by John Salvador on 6/1/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Initialize Window
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        
        // Initialize View Controller
        let viewControler = ViewController()
        
        // Set Root View Controller
        window?.rootViewController = viewControler
        
        // Set Window Make Key and Visible
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

