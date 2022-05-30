//
//  ProfileRequest.swift
//  Banco
//
//  Created by John Salvador on 5/30/22.
//

import Foundation


struct ProfileRequest {
    
    // MARK: - Properties
    
    let baseUrl: URL
    
    // MARK: -
    
    let userID: Int
    
    // MARK: -
    private let profilePath = "profile"
    
    var url: URL {
        return baseUrl.appendingPathComponent("\(profilePath)/\(userID)")
    }
    
}
