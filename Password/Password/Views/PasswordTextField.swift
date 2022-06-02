//
//  PasswordTextField.swift
//  Password
//
//  Created by John Salvador on 6/1/22.
//

import UIKit

class PasswordTextField: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PasswordTextField should not be initialized using init(coder:)")
    }
    
    // MARK: -
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "New password"
        textField.isSecureTextEntry = true
        
        // Add Lock Image on left side
        let paddedView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let lockImage = UIImage(systemName: "lock.fill")?.withTintColor(.systemBlue)
        let lockImageView = UIImageView(image: lockImage)
        lockImageView.center = CGPoint(x: paddedView.frame.size.width / 2, y: paddedView.frame.size.height / 2)
        lockImageView.contentMode = .center
        paddedView.addSubview(lockImageView)
        textField.leftView = paddedView
        textField.leftViewMode = .always
        
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private lazy var showPasswordButton: UIButton = {
        let showPasswordButton = UIButton()
        showPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        showPasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        showPasswordButton.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        return showPasswordButton
    }()
    
    private lazy var dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.text = "Your password must meet the requirements below."
        return label
    }()
    
    // MARK: - Public API
    var text: String {
        if let text = textField.text {
            return text
        }
        
        return ""
    }
    
    
    // MARK: - Helper Methods
    
    private func commonInit() {
        // Create Stack View
        let stackView = UIStackView(arrangedSubviews: [textField, dividerLineView, errorLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            dividerLineView.widthAnchor.constraint(equalTo: widthAnchor),
            dividerLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
//        self.backgroundColor = .systemPink
    }
 
    // MARK: - Actions
    
    @objc private func showPasswordButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        textField.isSecureTextEntry.toggle()
    }
    
}
