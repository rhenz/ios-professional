//
//  OnboardingViewController.swift
//  Banco
//
//  Created by John Salvador on 5/6/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - Stored Properties
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    
    let imageName: String
    let onboardingTitle: String
    
    // MARK: - Init
    init(imageName: String, withTitle onboardingTitle: String) {
        self.imageName = imageName
        self.onboardingTitle = onboardingTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

// MARK: - UI
extension OnboardingViewController {
    func style() {
        view.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = onboardingTitle
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
    }
    
    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
    }
}
