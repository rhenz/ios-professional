//
//  PasswordStatusView.swift
//  Password
//
//  Created by John Salvador on 6/3/22.
//

import UIKit

class PasswordStatusView: UIView {
        
    // MARK: -
    private lazy var criteriaLabelViewNumOfCharacters: CriteriaLabelView = {
        let label = CriteriaLabelView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "8-32 characters (no spaces)"
        label.criteriaResult = .passed
        return label
    }()
    
    private lazy var criteriaLabelViewUppercaseLetter: CriteriaLabelView = {
        let label = CriteriaLabelView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "uppercase letter (A-Z)"
        label.criteriaResult = .passed
        return label
    }()
    
    private lazy var criteriaLabelViewLowercaseLetter: CriteriaLabelView = {
        let label = CriteriaLabelView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "lowercase (a-z)"
        label.criteriaResult = .passed
        return label
    }()
    
    private lazy var criteriaLabelViewDigit: CriteriaLabelView = {
        let label = CriteriaLabelView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "digit (0-9)"
        label.criteriaResult = .passed
        return label
    }()
    
    private lazy var criteriaLabelViewSpecialCharacter: CriteriaLabelView = {
        let label = CriteriaLabelView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "special character (e.g. !@#$%^)"
        label.criteriaResult = .passed
        return label
    }()
    
    private lazy var criteriaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Use at least 3 of these 4 criteria when setting your password:"
        label.textColor = .systemGray
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PasswordStatusView should not be initialized using init(coder:)")
    }
    
    // MARK: -
    private func commonInit() {
        let stackView = UIStackView(arrangedSubviews: [criteriaLabelViewNumOfCharacters,
                                                       criteriaLabel,
                                                       criteriaLabelViewUppercaseLetter,
                                                       criteriaLabelViewLowercaseLetter,
                                                       criteriaLabelViewDigit,
                                                       criteriaLabelViewSpecialCharacter
                                                      ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Public API
    public func update(characterCriteria: Bool, uppercaseCriteria: Bool, lowercaseCriteria: Bool, digitCriteria: Bool, specialCharacterCriteria: Bool) {
        
        criteriaLabelViewNumOfCharacters.criteriaResult = characterCriteria ? .passed : .failed
        criteriaLabelViewUppercaseLetter.criteriaResult = uppercaseCriteria ? .passed : .failed
        criteriaLabelViewLowercaseLetter.criteriaResult = lowercaseCriteria ? .passed : .failed
        criteriaLabelViewDigit.criteriaResult = digitCriteria ? .passed : .failed
        criteriaLabelViewSpecialCharacter.criteriaResult = specialCharacterCriteria ? .passed : .failed
    }
}


// MARK: -
fileprivate enum CriteriaResult {
    case passed
    case failed
}


// MARK: -
fileprivate class CriteriaLabelView: UIView {
    
    // MARK: - Properties
    
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    var criteriaResult: CriteriaResult = .failed {
        didSet {
            switch criteriaResult {
            case .passed:
                imageView.image = passImage
            case .failed:
                imageView.image = failImage
            }
        }
    }
    
    // MARK: -
    private let passImage = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    private let failImage = UIImage(systemName: "xmark.circle")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    
    
    // MARK: -
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
     
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("CriteriaLabelView should not be initialized using init(coder:)")
    }
    
    // MARK: - Helper Methods
    private func commonInit() {
        let stackView = UIStackView(arrangedSubviews: [imageView, textLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
