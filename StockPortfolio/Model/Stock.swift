//
//  Stock.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation

struct Stock: Decodable {
    let symbol: String
    let companyName: String
    let latestPrice: Double
    let previousClose: Double
    let logo: URL
}
