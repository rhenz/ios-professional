//
//  PasswordStatusView.swift
//  Password
//
//  Created by John Salvador on 6/3/22.
//

import UIKit

enum Styles {
    enum Fonts {
        static let main = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let mainBold = UIFont.systemFont(ofSize: 15, weight: .bold)
    }
}

class PasswordStatusView: UIView {
        
    // MARK: -
    private lazy var criteriaLabelViewNumOfCharacters: CriteriaLabelView = {
        let label = CriteriaLabelView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "8-32 characters (no spaces)"
        return label
    }()
    
    private lazy var criteriaLabelViewUppercaseLetter: CriteriaLabelView = {
        let label = CriteriaLabelView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "uppercase letter (A-Z)"
        return label
    }()
    
    private lazy var criteriaLabelViewLowercaseLetter: CriteriaLabelView = {
        let label = CriteriaLabelView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "lowercase (a-z)"
        return label
    }()
    
    private lazy var criteriaLabelViewDigit: CriteriaLabelView = {
        let label = CriteriaLabelView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "digit (0-9)"
        return label
    }()
    
    private lazy var criteriaLabelViewSpecialCharacter: CriteriaLabelView = {
        let label = CriteriaLabelView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "special character (e.g. !@#$%^)"
        return label
    }()
    
    private lazy var criteriaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = makeCriteriaMessage()
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
        
        // Setup background view with rounded corners
        backgroundColor = .systemGray5.withAlphaComponent(0.5)
        layer.cornerRadius = 5
        clipsToBounds = true
        
        // Setup stack view
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
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Helper Methods
    private func makeCriteriaMessage() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        plainTextAttributes[.font] = Styles.Fonts.main
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = Styles.Fonts.mainBold
        
        let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))
        
        return attrText
    }
    
    // MARK: - Public API
    public func update(characterCriteria: CriteriaResult, uppercaseCriteria: CriteriaResult, lowercaseCriteria: CriteriaResult, digitCriteria: CriteriaResult, specialCharacterCriteria: CriteriaResult) {
        
        criteriaLabelViewNumOfCharacters.criteriaResult = characterCriteria
        criteriaLabelViewUppercaseLetter.criteriaResult = uppercaseCriteria
        criteriaLabelViewLowercaseLetter.criteriaResult = lowercaseCriteria
        criteriaLabelViewDigit.criteriaResult = digitCriteria
        criteriaLabelViewSpecialCharacter.criteriaResult = specialCharacterCriteria
    }
}


// MARK: -
enum CriteriaResult {
    case empty
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
    
    var criteriaResult: CriteriaResult = .empty {
        didSet {
            switch criteriaResult {
            case .empty:
                imageView.image = UIImage(systemName: "circle")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            case .passed:
                imageView.image = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            case .failed:
                imageView.image = UIImage(systemName: "xmark.circle")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            }
        }
    }
    
    // MARK: -
    
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
        label.font = Styles.Fonts.main
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
        // Set initial criteria image view
        criteriaResult = .empty
        
        // Create stack view
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
