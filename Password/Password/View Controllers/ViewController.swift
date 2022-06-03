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
    private var passwordStatusView = PasswordStatusView()
    
    private var passwordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.placeholder = "New Password"
        return textField
    }()
    
    private var confirmPasswordtextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.placeholder = "Re-enter new password"
        return textField
    }()
    
    private lazy var resetPasswordButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("Reset password", for: .normal)
        button.addTarget(self, action: #selector(resetPasswordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.passwordStatusView.update(characterCriteria: .failed, uppercaseCriteria: .empty, lowercaseCriteria: .passed, digitCriteria: .passed, specialCharacterCriteria: .failed)
        }
    }
    
    // MARK: - Actions
    @objc private func resetPasswordButtonTapped(_ sender: UIButton) {
        print("Reset Password Button Pressed")
    }
}

// MARK: - Setup View
extension ViewController {
    private func setupView() {
        let _ = view.safeAreaLayoutGuide
        let margin = view.layoutMarginsGuide
        
        // Setup stack view
        let stackView = UIStackView(arrangedSubviews: [passwordTextField, passwordStatusView, confirmPasswordtextField, resetPasswordButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // Configure Stack View Constraints
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: margin.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: margin.rightAnchor),
            
            // Configure Reset Button Constraints
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

