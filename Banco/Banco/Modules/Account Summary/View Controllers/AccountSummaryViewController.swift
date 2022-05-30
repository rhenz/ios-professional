//
//  AccountSummaryViewController.swift
//  Banco
//
//  Created by John Salvador on 5/13/22.
//

import UIKit



class AccountSummaryViewController: UIViewController {
    
    // MARK: - Properties
    
    private var accounts: [AccountSummaryCell.ViewModel] = []
    private let tableView = UITableView()
    
    private var shakeBellTimer: Timer? = nil
    
    private var shakeyBellView: ShakeyBellView {
        accountSummaryHeaderView.shakeyBellView
    }
    
    
    private var accountSummaryHeaderView = AccountSummaryHeaderView() {
        didSet {
            accountSummaryHeaderView.isHidden = true
        }
    }
    
    var accountProfileViewModel: AccountProfileViewModel? {
        didSet {
            if let accountSummaryHeaderViewModel = accountProfileViewModel {
                setupAccountHeaderView(with: accountSummaryHeaderViewModel)
            }
        }
    }
    
    var bankAccountsProfileViewModel: BankAccountsProfileViewModel? {
        didSet {
            if let bankAccountsProfileViewModel = bankAccountsProfileViewModel {
                setupBankAccountsViewModel(with: bankAccountsProfileViewModel)
            }
        }
    }
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Helper Methods
    private func setupViews() {
        // Set View's Background Color
        self.view.backgroundColor = .systemBackground
        
        // Add Bar Button Item
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        logoutButton.tintColor = .label
        navigationItem.rightBarButtonItem = logoutButton
        
        // Setup Table View
        setupTableView()
        setupTableHeaderView()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.cellIdentifier)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        tableView.isHidden = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Add Activity Indicator on top of Table View
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
    }
    
    private func setupTableHeaderView() {
        accountSummaryHeaderView = AccountSummaryHeaderView()
        
        var size = accountSummaryHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        accountSummaryHeaderView.frame.size = size
        tableView.tableHeaderView = accountSummaryHeaderView
        
        // Set Delegate
        shakeyBellView.delegate = self
        
        // Shake Bell View
        shakeBellTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(shakeBellView), userInfo: nil, repeats: true)
    }
    
    @objc private func shakeBellView() {
        shakeyBellView.shakeBell()
    }
    
    private func setupAccountHeaderView(with viewModel: AccountProfileViewModel) {
        accountSummaryHeaderView.configureHeaderView(with: viewModel)
        accountSummaryHeaderView.isHidden = false
    }
    
    private func setupBankAccountsViewModel(with viewModel: BankAccountsProfileViewModel) {
        // Stop Animating
        activityIndicatorView.stopAnimating()
        
        // Reload Table View
        tableView.reloadData()
        tableView.isHidden = false
    }
}

// MARK: -
extension AccountSummaryViewController: ShakeyBellViewDelegate {
    func didTapBell() {
        // Stop shaking bell
        shakeBellTimer?.invalidate()
    }
}


// MARK: - Actions
extension AccountSummaryViewController {
    @objc private func logoutTapped(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}

// MARK: - Table view data source
extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankAccountsProfileViewModel?.numberOfBankAccountProfile ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.cellIdentifier, for: indexPath) as? AccountSummaryCell else {
            fatalError("Failed to dequeueReusableCell for AccountSummaryCell")
        }
        
        // Configure Cell
        if let viewModel = bankAccountsProfileViewModel?.viewModel(for: indexPath.item) {
            cell.configure(with: viewModel)
        }
        
        return cell
    }
}

// MARK: - Table view delegate
extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
