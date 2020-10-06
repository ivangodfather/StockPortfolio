//
//  ListType.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 06/10/2020.
//

import Foundation

enum ListType: Int, CustomStringConvertible, CaseIterable, Identifiable {
    case gainers = 0
    case losers
    case mostActive

    var description: String {
        switch self {
        case .gainers: return "Gainers"
        case .losers: return "Losers"
        case .mostActive: return "Most Active"
        }
    }

    var apiDescription: String {
        switch self {
        case .gainers: return "gainers"
        case .losers: return "losers"
        case .mostActive: return "mostactive"
        }
    }

    var id: Int { rawValue }
}
