//
//  BankAccountViewModelTests.swift
//  BancoUnitTests
//
//  Created by John Salvador on 5/30/22.
//

import XCTest
@testable import Banco

class BankAccountViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var viewModel: BankAccountProfileViewModel!

    
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
        viewModel = BankAccountProfileViewModel(bankAccountProfile: bankAccounts[1])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Tests
    /*
     {
         "id": "2",
         "type": "Banking",
         "name": "No-Fee All-In Chequing",
         "amount": 17562.44,
         "createdDateTime": "2011-06-21T15:29:32Z"
     }
     */
    
    func test_id() {
        XCTAssertEqual(viewModel.id, "2")
    }
    
    func test_type() {
        XCTAssertEqual(viewModel.type, .banking)
    }
    
    func test_name() {
        XCTAssertEqual(viewModel.name, "No-Fee All-In Chequing")
    }
    
    func test_amount() {
        XCTAssertEqual(viewModel.amount, 17562.44)
    }
    
    func test_createdDateTime() {
        let date = try! Date("2011-06-21T15:29:32Z", strategy: .iso8601)
        XCTAssertEqual(viewModel.createdDateTime, date)
    }
}
