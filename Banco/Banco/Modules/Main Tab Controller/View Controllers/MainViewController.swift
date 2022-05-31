//
//  MainViewController.swift
//  Banco
//
//  Created by John Salvador on 5/13/22.
//

import UIKit

class MainViewController: UITabBarController {
    
    // MARK: - Types
    enum AlertTypes {
        case failedToFetchProfile
        case failedToFetchBankAccounts
    }

    // MARK: - Properties
    var viewModel: MainViewModel? {
        didSet {
            if let viewModel = viewModel {
                setupViewModel(with: viewModel)
            }
        }
    }
    
    private lazy var accountSummaryVC: AccountSummaryViewController = {
        let accountSummaryVC = AccountSummaryViewController()
        accountSummaryVC.delegate = self
        return accountSummaryVC
    }()
    
    private lazy var moneyVC: MoneyViewController = {
        let moneyVC = MoneyViewController()
        return moneyVC
    }()
    
    private lazy var moreVC: MoreViewViewController = {
        let moreVC = MoreViewViewController()
        return moreVC
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Invoke Fetch Data
        viewModel?.refresh()
    }
    
    private func setupViews() {
        accountSummaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        
        let summaryNC = UINavigationController(rootViewController: accountSummaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        
        summaryNC.navigationBar.barTintColor = appColor
        hideNavigationBarLine(summaryNC.navigationBar)
        
        let tabBarList = [summaryNC, moneyNC, moreNC]
        
        viewControllers = tabBarList
    }
    
    private func setupViewModel(with viewModel: MainViewModel) {
        
        var errors: [Error] = []
        let dispatchGroup = DispatchGroup()
        
        
        // Fetch User Profile
        dispatchGroup.enter()
        viewModel.didFetchUserProfile = { [weak self] result in
            switch result {
            case let .success(profile):
                let accountSummaryHeaderViewModel = AccountProfileViewModel(profile: profile)
                self?.accountSummaryVC.accountProfileViewModel = accountSummaryHeaderViewModel
            case let .failure(error):
                errors.append(error)
            }
            dispatchGroup.leave()
        }
        
        // Fetch Bank Account Profile
        dispatchGroup.enter()
        viewModel.didFetchBankAccountProfile = { [weak self] result in
            switch result {
            case let .success(bankAccountProfiles):
                let bankAccountsViewModel = BankAccountsProfileViewModel(bankAccountsProfile: bankAccountProfiles)
                self?.accountSummaryVC.bankAccountsProfileViewModel = bankAccountsViewModel
            case let .failure(error):
                // Present Alert
                errors.append(error)
            }
            
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            // Present Alert if there's any
            guard !errors.isEmpty else {
                return
            }

            // There are some errors
            self?.showErrorFetchAlert()
        }
    }
    
    private func showErrorFetchAlert() {
        let ac = UIAlertController(title: "Server Error", message: "The application is unable to fetch profile and bank account data. Please make sure your device is connected over Wi-Fi or cellular.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = true
    }
    
}

// For refreshing view models
extension MainViewController: AccountSummaryViewControllerDelegate {
    func controllerDidRefresh(_ controller: AccountSummaryViewController) {
        viewModel?.refresh()
    }
}

// MARK: - Dummy VCs
class MoneyViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
}

class MoreViewViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemPurple
    }
}
