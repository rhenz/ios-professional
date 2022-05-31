//
//  MockNetworkService.swift
//  Banco
//
//  Created by John Salvador on 6/1/22.
//

import Foundation
@testable import Banco

class MockNetworkService: NetworkService {
    
    // MARK: - Properties
    
    var data: Data?
    var error: Error?
    var statusCode: Int = 200
    
    // MARK: - Network Service
    func fetchData(with url: URL, completionHandler: @escaping FetchDataCompletion) {
        // Create Response
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        
        // Invoke Handler
        completionHandler(data, response, error)
    }
}
