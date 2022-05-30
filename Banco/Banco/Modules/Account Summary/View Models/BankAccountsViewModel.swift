//
//  BankAccountsViewModel.swift
//  Banco
//
//  Created by John Salvador on 5/30/22.
//

import Foundation

struct BankAccountsProfileViewModel {
    
    // MARK: - Properties
    let bankAccountsProfile: [BankAccountProfile]
    
    
    var numberOfBankAccountProfile: Int {
        return bankAccountsProfile.count
    }
    
    // MARK: - Helper Methods
    func viewModel(for index: Int) -> BankAccountProfileViewModel {
        return BankAccountProfileViewModel(bankAccountProfile: bankAccountsProfile[index])
    }
}



