//
//  ViewController.swift
//  Password
//
//  Created by John Salvador on 6/1/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: -
    let passwordTextField = PasswordTextField()
    let passwordStatusView = PasswordStatusView()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Setup View
extension ViewController {
    private func setupView() {
        let _ = view.safeAreaLayoutGuide
        let margin = view.layoutMarginsGuide
        
        passwordStatusView.backgroundColor = .systemGray2.withAlphaComponent(0.1)
        
        let stackView = UIStackView(arrangedSubviews: [passwordTextField, passwordStatusView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: margin.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: margin.rightAnchor),
        ])
    }
}

