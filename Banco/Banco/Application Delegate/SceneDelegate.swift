//
//  SceneDelegate.swift
//  Banco
//
//  Created by John Salvador on 5/14/22.
//

import UIKit

let appColor: UIColor = .systemTeal

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties
    var window: UIWindow?
    
    let onboardingViewController = OnboardingContainerViewController()
    let loginViewController = LoginViewController()
    let mainViewController = MainViewController()
    
    // MARK: -
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        loginViewController.delegate = self
        onboardingViewController.delegate = self
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
        
        self.window = UIWindow(windowScene: windowScene)
        
        mainViewController.setStatusBar()
        self.window?.rootViewController = mainViewController
        self.window?.makeKeyAndVisible()
    }
}

// MARK: - LoginViewControllerDelegate
extension SceneDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingViewController)
        }
    }
}

// MARK: - OnboardingViewController Delegate
extension SceneDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        setRootViewController(mainViewController)
        LocalState.hasOnboarded = true
    }
}

// MARK: - LogoutDelegate
extension SceneDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

// MARK: -
extension SceneDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated,
              let window = self.window
        else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }
}
