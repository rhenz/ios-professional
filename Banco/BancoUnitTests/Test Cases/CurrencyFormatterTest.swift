//
//  CurrencyFormatterTest.swift
//  BancoUnitTests
//
//  Created by John Salvador on 5/17/22.
//

import Foundation
import XCTest

@testable import Banco

class CurrencyFormatterTest: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    // MARK: - Test
    func test_breakIntoCurrencyTypeAndCents() throws {
        let result = formatter.breakIntoCurrencyTypeAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func test_currencyFormatted() throws {
        let result = formatter.currencyFormmater(929466.23)
        XCTAssertEqual(result, "₱929,466.23")
    }
    
    func test_zeroAmountFormatted() throws {
        let result = formatter.currencyFormmater(0)
        XCTAssertEqual(result, "₱0.00")
    }
    
    func test_currencyFormattedWithSymbol() throws {
        let locale = Locale(identifier: "en_PH")
        let currencySymbol = locale.currencySymbol!
        
        let result = formatter.currencyFormmater(929466.23)
        XCTAssertEqual(result, "\(currencySymbol)929,466.23")
    }
}
