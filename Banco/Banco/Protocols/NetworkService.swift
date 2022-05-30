//
//  NetworkService.swift
//  Banco
//
//  Created by John Salvador on 5/30/22.
//

import Foundation

protocol NetworkService {
    
    // MARK: - Type Aliases
    typealias FetchDataCompletion = (Data?, URLResponse?, Error?) -> Void
    
    // MARK: - Methods
    func fetchData(with url: URL, completionHandler: @escaping FetchDataCompletion)
    
}
