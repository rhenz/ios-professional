//
//  BankAccountProfile.swift
//  Banco
//
//  Created by John Salvador on 5/30/22.
//

import Foundation


enum AccountType: String, Codable {
    case banking = "Banking"
    case creditCard = "CreditCard"
    case investment = "Investment"
}

struct BankAccountProfile: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Double
    let createdDateTime: Date
}
