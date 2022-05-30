//
//  AccountSummaryHeaderViewModel.swift
//  Banco
//
//  Created by John Salvador on 5/29/22.
//

import Foundation

struct AccountProfileViewModel {
    
    // MARK: -
    fileprivate enum TimeOfDay {
        case morning
        case afternoon
        case evening
        case unknown
        
        var greeting: String {
            switch self {
            case .morning:
                return "Good Morning,"
            case .afternoon:
                return "Good Afternoon,"
            case .evening:
                return "Good Evening,"
            case .unknown:
                return "Time Unknown,"
            }
        }
        
        /// hour: will range from 0 to 24
        init(_ hour: Int) {
            switch hour {
            case 0..<12:
                self = .morning
            case 12..<16:
                self = .afternoon
            case 16..<24:
                self = .evening
            default:
                self = .unknown
            }
        }
    }
    
    // MARK: - Properties
    let profile: Profile
    
    var name: String {
        return "\(profile.firstName) \(profile.lastName)"
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy hh:mm:a"
        return dateFormatter.string(from: Date())
    }
    
    var welcomeMessage: String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        return TimeOfDay(hour).greeting
    }
}

extension AccountProfileViewModel: AccountSummaryRepresentable { }
