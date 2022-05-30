//
//  BankAccountViewModel.swift
//  Banco
//
//  Created by John Salvador on 5/30/22.
//

import Foundation

struct BankAccountProfileViewModel {
    // MARK: - Properties
    let bankAccountProfile: BankAccountProfile
    
    // MARK: - 
    
    var id: String {
        bankAccountProfile.id
    }
    
    var type: AccountType {
        bankAccountProfile.type
    }
    
    var name: String {
        bankAccountProfile.name
    }
    
    var amount: Double {
        bankAccountProfile.amount
    }
    
    var createdDateTime: Date {
        bankAccountProfile.createdDateTime
    }
}

extension BankAccountProfileViewModel: BankAccountProfileRepresentable { }
