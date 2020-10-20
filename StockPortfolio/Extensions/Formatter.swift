//
//  Formatter.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 20/10/2020.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
}
