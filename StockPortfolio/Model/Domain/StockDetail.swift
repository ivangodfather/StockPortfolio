//
//  Stock.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation

struct StockDetail {
    let symbol: String
    let shares: Int
    
    let companyName: String
    let latestPrice: Double
    let previousClose: Double
    let logo: URL

    var percentage: Double {
        latestPrice.percentage(from: previousClose)
    }

}

extension StockDetail: Identifiable {
    var id: String { symbol }
}

