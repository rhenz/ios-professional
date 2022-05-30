//
//  AccountSummaryHeaderRepresentable.swift
//  Banco
//
//  Created by John Salvador on 5/30/22.
//

import Foundation

protocol AccountSummaryRepresentable {
    var name: String { get }
    var date: String { get }
    var welcomeMessage: String { get }
}
