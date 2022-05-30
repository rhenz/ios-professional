//
//  NetworkManager.swift
//  Banco
//
//  Created by John Salvador on 5/30/22.
//

import Foundation

class NetworkManager: NetworkService {
    func fetchData(with url: URL, completionHandler: @escaping FetchDataCompletion) {
        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }
}
