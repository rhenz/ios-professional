//
//  CurrencyFormatter.swift
//  Banco
//
//  Created by John Salvador on 5/16/22.
//

import UIKit
import Foundation

struct CurrencyFormatter {
    
    func makeAttributedCurrency(_ amount: Decimal) -> NSMutableAttributedString {
        let tuple = breakIntoCurrencyTypeAndCents(amount)
        return makeBalanceAttributed(currencyType: tuple.0, cents: tuple.1)
    }
    
    // Converts 929466.23 > "929,466" "23"
    func breakIntoCurrencyTypeAndCents(_ amount: Decimal) -> (String, String) {
        let tuple = modf(amount.doubleValue)
        
        let currencyType = convertCurrency(tuple.0)
        let cents = convertCents(tuple.1)
        
        return (currencyType, cents)
    }
    
    // Converts 929466 > 929,466
    private func convertCurrency(_ currencyPart: Double) -> String {
        let currencyWithDecimal = currencyFormmater(currencyPart) // "$929,466.00"
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_PH")
        let decimalSeparator = formatter.decimalSeparator! // "."
        let currencyComponents = currencyWithDecimal.components(separatedBy: decimalSeparator) // "$929,466" "00"
        var currency = currencyComponents.first! // "$929,466"
        currency.removeFirst() // "929,466"
        
        return currency
    }
    
    // Convert 0.23 > 23
    private func convertCents(_ centPart: Double) -> String {
        let cents: String
        if centPart == 0 {
            cents = "00"
        } else {
            cents = String(format: "%.0f", centPart * 100)
        }
        return cents
    }
    
    // Converts 929466 > $929,466.00
    func currencyFormmater(_ currency: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_PH")
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        if let result = formatter.string(from: currency as NSNumber) {
            return result
        }
        
        return ""
    }
    
    private func makeBalanceAttributed(currencyType: String, cents: String) -> NSMutableAttributedString {
        let currencySignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let currencyAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "₱", attributes: currencySignAttributes)
        let currencyString = NSAttributedString(string: currencyType, attributes: currencyAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(currencyString)
        rootString.append(centString)
        
        return rootString
    }
}

extension Decimal {
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
