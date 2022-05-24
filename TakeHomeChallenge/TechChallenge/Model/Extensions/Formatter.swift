//
//  Formatter.swift
//  TechChallenge
//
//  Created by Alexandru Pop on 23/05/2022.
//

import Foundation

extension Formatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
}
