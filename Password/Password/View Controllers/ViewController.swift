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
    
    private lazy var passwordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.placeholder = "New Password"
        textField.setDelegate(self)
        return textField
    }()
    
    private lazy var confirmPasswordtextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.placeholder = "Re-enter new password"
        textField.setDelegate(self)
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
    }
    
    // MARK: - Actions
    @objc private func resetPasswordButtonTapped(_ sender: UIButton) {
        print("Reset Password Button Pressed")
        
        if passwordTextField.text != confirmPasswordtextField.text {
            confirmPasswordtextField.showError("The Confirm Password confirmation does not match")
        } else {
            confirmPasswordtextField.hideErrorLabel()
        }
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

// MARK: - Textfield Delegate
extension ViewController: UITextFieldDelegate, PasswordTextFieldDelegate {
    func textfieldDidChange(_ textField: PasswordTextField) {
        print("TEXT: \(textField.text)")
        if textField === passwordTextField {
            passwordStatusView.updateDisplay(textField.text)
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextField.textField {
            print("LOL")
            passwordStatusView.checkEmptyResult()
        }
    }
    
}
