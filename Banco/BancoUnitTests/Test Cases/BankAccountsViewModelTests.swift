//
//  BankAccountsViewModelTests.swift
//  BancoUnitTests
//
//  Created by John Salvador on 5/30/22.
//

import XCTest
@testable import Banco

class BankAccountsViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var viewModel: BankAccountsProfileViewModel!

    // MARK: - Set Up & Tear Down
    override func setUpWithError() throws {
        // Load Stub
        let data = loadStub(name: "bankAccounts", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        
        // Initialize Response
        let bankAccounts = try! decoder.decode([BankAccountProfile].self, from: data)
        
        // Initialize View Model
        viewModel = BankAccountsProfileViewModel(bankAccountsProfile: bankAccounts)
    }

  
    // MARK: - Tests
    func test_numberOfBankAccounts() {
        XCTAssertEqual(viewModel.numberOfBankAccountProfile, 6)
    }
    
    func test_viewModelForIndex() {
        let bankAccountViewModel = viewModel.viewModel(for: 1)
        
        XCTAssertEqual(bankAccountViewModel.id, "2")
        XCTAssertEqual(bankAccountViewModel.name, "No-Fee All-In Chequing")
        
        let date = try! Date("2011-06-21T15:29:32Z", strategy: .iso8601)
        XCTAssertEqual(bankAccountViewModel.createdDateTime, date)
    }

}
