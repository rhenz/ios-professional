//
//  MainViewController.swift
//  Banco
//
//  Created by John Salvador on 5/13/22.
//

import UIKit

class MainViewController: UITabBarController {

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
        
        // Fetch User Profile
        viewModel.didFetchUserProfile = { [weak self] result in
            switch result {
            case let .success(profile):
                let accountSummaryHeaderViewModel = AccountProfileViewModel(profile: profile)
                self?.accountSummaryVC.accountProfileViewModel = accountSummaryHeaderViewModel
            case let .failure(error):
                // Present Alert
                print(error)
            }
        }
        
        // Fetch Bank Account Profile
        viewModel.didFetchBankAccountProfile = { [weak self] result in
            switch result {
            case let .success(bankAccountProfiles):
                let bankAccountsViewModel = BankAccountsProfileViewModel(bankAccountsProfile: bankAccountProfiles)
                self?.accountSummaryVC.bankAccountsProfileViewModel = bankAccountsViewModel
            case let .failure(error):
                // Present Alert
                print(error)
            }
        }
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
