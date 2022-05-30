//
//  AccountProfileViewModelTests.swift
//  BancoUnitTests
//
//  Created by John Salvador on 5/30/22.
//

import XCTest
@testable import Banco

class AccountProfileViewModelTests: XCTestCase {
    
    var viewModel: AccountProfileViewModel!

    override func setUpWithError() throws {
        
        // Load Stub
        let data = loadStub(name: "profile", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        
        // Set Decoding Strategy
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // Initialize Response
        let profile = try! decoder.decode(Profile.self, from: data)
        
        // Initialize View Model
        viewModel = AccountProfileViewModel(profile: profile)
    }

    
    // MARK: - Tests
    func test_name() {
        XCTAssertEqual(viewModel.name, "Kevin Flynn")
    }
    
    func test_date() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Styles.DateFormat.main
        
        XCTAssertEqual(viewModel.date, dateFormatter.string(from: Date()))
    }
    
    func test_welcomeMessage() {
        let hour = Calendar.current.component(.hour, from: Date())
        
        var welcomeMessage = ""
        switch hour {
        case 0..<12:
            welcomeMessage = "Good Morning,"
        case 12..<16:
            welcomeMessage = "Good Afternoon,"
        case 16..<24:
            welcomeMessage = "Good Evening,"
        default:
            welcomeMessage = "Unknown Time"
        }
        
        XCTAssertEqual(viewModel.welcomeMessage, welcomeMessage)
    }

}
