//
//  MainViewModelTests.swift
//  BancoUnitTests
//
//  Created by John Salvador on 6/1/22.
//

import XCTest
@testable import Banco

class MainViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: MainViewModel!
    
    // Initialize Mock Network Service
    let networkService = MockNetworkService()
    
    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        // Initialize Main View Model
        viewModel = MainViewModel(networkService: networkService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /*
    {
        "id": "1",
        "type": "Banking",
        "name": "Basic Savings",
        "amount": 929466.23,
        "createdDateTime": "2010-06-21T15:29:32Z"
    }
     */

    // MARK: - Tests
    func test_fetchProfile() {
        // Configure Mock Network Service
        networkService.data = loadStub(name: "profile", extension: "json")
        
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Profile Data")
        
        // Install Handler
        viewModel.didFetchUserProfile = { result in
            if case let .success(profile) = result {
                XCTAssertEqual(profile.id, "1")
                XCTAssertEqual(profile.firstName, "Kevin")
                XCTAssertEqual(profile.lastName, "Flynn")
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.refresh()
        
        // Wait for Expectation to be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_fetchBankAccounts() {
        // Configure Mock Network Service
        networkService.data = loadStub(name: "bankAccounts", extension: "json")
        
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Bank Accounts")
        
        // Install Handler
        viewModel.didFetchBankAccountProfile = { result in
            if case let .success(bankAccounts) = result {
                if let bankAccount = bankAccounts.first {
                    XCTAssertEqual(bankAccounts.count, 6)
                    XCTAssertEqual(bankAccount.type, .banking)
                    XCTAssertEqual(bankAccount.name, "Basic Savings")
                    XCTAssertEqual(bankAccount.amount, 929466.23)
                    XCTAssertEqual(bankAccount.createdDateTime, try! Date("2010-06-21T15:29:32Z", strategy: .iso8601))
                } else {
                    XCTFail("Bank Accounts nil")
                }
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.refresh()
        
        // Wait for Expectation to be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }

}
