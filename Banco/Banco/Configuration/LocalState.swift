//
//  LocalState.swift
//  Banco
//
//  Created by John Salvador on 5/12/22.
//

import Foundation

public enum LocalState {
    private static let defaults = UserDefaults.standard
    
    private enum Keys: String {
        case hasOnboarded
    }
    
    public static var hasOnboarded: Bool {
        get { return defaults.bool(forKey: Keys.hasOnboarded.rawValue) }
        set { defaults.set(newValue, forKey: Keys.hasOnboarded.rawValue) }
    }
}
