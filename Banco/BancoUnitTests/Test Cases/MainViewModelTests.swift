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
    
    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        
        // Initialize Mock Network Service
        let networkService = MockNetworkService()
        
        // Configure Mock Network Service
        networkService.data = loadStub(name: "profile", extension: "json")
        
        // Initialize Main View Model
        viewModel = MainViewModel(networkService: networkService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Tests
    func test_fetchProfile() {
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

}
