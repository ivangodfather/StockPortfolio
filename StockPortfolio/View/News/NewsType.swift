//
//  NewsType.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 04/10/2020.
//

import Foundation

enum NewsType: Int, CaseIterable, CustomStringConvertible {
    case yourStocks = 0
    case world

    var description: String {
        switch self {
        case .yourStocks: return "Your stocks"
        case .world: return "All news"
        }
    }
}
