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
    let news: [News]

    var percentage: Double {
        latestPrice.percentage(from: previousClose)
    }

    struct News: Identifiable {
        let headline: String
        let source: String
        let url: URL
        let summary: String
        var id: String { headline }
    }
}
