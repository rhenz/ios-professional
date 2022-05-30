//
//  BankAccountProfileRequest.swift
//  Banco
//
//  Created by John Salvador on 5/30/22.
//

import Foundation

struct BankAccountProfileRequest {
    
    // MARK: - Properties
    let baseUrl: URL
    
    // MARK: -
    let userID: Int
    
    // MARK: -
    private var bankAccountProfilePath: String {
        return "profile/\(userID)/accounts"
    }
    
    var url: URL {
        return baseUrl.appendingPathComponent(bankAccountProfilePath)
    }
}
