//
//  BankAccountProfileRepresentable.swift
//  Banco
//
//  Created by John Salvador on 5/30/22.
//

import Foundation

protocol BankAccountProfileRepresentable {
    var id: String { get }
    var type: AccountType { get }
    var name: String { get }
    var amount: Double { get }
    var createdDateTime: Date { get }
    var balanceAsAttributedString: NSAttributedString { get }
}

extension BankAccountProfileRepresentable {
    var balanceAsAttributedString: NSAttributedString {
        return CurrencyFormatter().makeAttributedCurrency(Decimal(amount))
    }
}
