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
        self.window = UIWindow(windowScene: windowScene)
        
        // Set Delegates
        loginViewController.delegate = self
        onboardingViewController.delegate = self
        
        // Display Login
        displayLogin()
    }
    
    private func displayLogin() {
        setRootViewController(loginViewController, animated: false)
    }
    
    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepMainView()
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingViewController)
        }
    }
    
    private func prepMainView() {
        // Set Status Bar Appearance
        mainViewController.setStatusBar()
        
        // Set Navigation Bar Color
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
    }
}

// MARK: - LoginViewControllerDelegate
extension SceneDelegate: LoginViewControllerDelegate {
    func didLogin() {
        displayNextScreen()
    }
}

// MARK: - OnboardingViewController Delegate
extension SceneDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepMainView()
        setRootViewController(mainViewController)
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
            self.window?.backgroundColor = .systemBackground
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }
}
