//
//  MainViewModel.swift
//  Banco
//
//  Created by John Salvador on 5/30/22.
//

import Foundation

class MainViewModel: NSObject {
    
    // MARK: - Types
    enum FetchProfileError: Error {
        case noProfileDataAvailable
        case other(Error)
    }
    
    enum FetchBankAccountsError: Error {
        case noBankAccountsAvailable
        case other(Error)
    }
    
    // MARK: - Properties
    var networkService: NetworkService
    
    // MARK: - Type Aliases
    typealias FetchUserProfileCompletion = (Result<Profile, FetchProfileError>) -> Void
    typealias FetchBankAccountProfileCompletion = (Result<[BankAccountProfile], FetchBankAccountsError>) -> Void
    
    var didFetchUserProfile: FetchUserProfileCompletion?
    var didFetchBankAccountProfile: FetchBankAccountProfileCompletion?
    
    // MARK: - Init
    init(networkService: NetworkService) {
        self.networkService = networkService
        
        super.init()
        
//        // Fetch Profile Data
//        fetchUserProfile()
//
//        // Fetch Bank Account profile
//        fetchBankAccountProfile()
    }
    
    // MARK: - Public API
    func refresh() {
        // Fetch Profile Data
        fetchUserProfile()
        
        // Fetch Bank Account profile
        fetchBankAccountProfile()
    }
    
    // MARK: - Helper Methods
    private func fetchUserProfile(with userID: Int = 1) {
        let request = ProfileRequest(baseUrl: BancoService.baseUrl, userID: userID)
        
        networkService.fetchData(with: request.url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Fetch User Profile Status Code: \(response.statusCode)")
            }
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Unable to fetch User Profile: \(error)")
                    
                    // Invoke Completion Handler
                    self?.didFetchUserProfile?(.failure(.noProfileDataAvailable))
                } else if let data = data {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    do {
                        let profileData = try decoder.decode(Profile.self, from: data)
                        
                        // Invoke Completion Handler
                        self?.didFetchUserProfile?(.success(profileData))
                    } catch {
                        // Invoke Completion Handler
                        self?.didFetchUserProfile?(.failure(.other(error)))
                    }
                    
                } else {
                    // Invoke Completion Handler
                    self?.didFetchUserProfile?(.failure(.noProfileDataAvailable))
                }
            }
        }
    }
    
    private func fetchBankAccountProfile(with userID: Int = 1) {
        let request = BankAccountProfileRequest(baseUrl: BancoService.baseUrl, userID: userID)
        
        networkService.fetchData(with: request.url) { [weak self] data, response, error in
            if let response = response as? HTTPURLResponse {
                print("Bank Account Profile Request Status Code: \(response.statusCode)")
            }
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Unable to fetch Bank Account Profile: \(error)")
                    
                    self?.didFetchBankAccountProfile?(.failure(.noBankAccountsAvailable))
                } else if let data = data {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    do {
                        let bankAccountProfileData = try decoder.decode([BankAccountProfile].self, from: data)
                     
                        // Invoke Completion Handler
                        self?.didFetchBankAccountProfile?(.success(bankAccountProfileData))
                    } catch {
                        // Invoke Completion Handler
                        self?.didFetchBankAccountProfile?(.failure(.other(error)))
                    }
                } else {
                    // Invoke Completion Handler
                    self?.didFetchBankAccountProfile?(.failure(.noBankAccountsAvailable))
                }
            }
        }
    }
}
