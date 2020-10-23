//
//  IEXResponse.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation

struct IEXQuote: Decodable {
    let symbol: String
    let companyName: String
    let latestPrice: Double?
    let previousClose: Double?
    let changePercent: Double
    let change: Double?
    let latestUpdate: Double?
    let marketCap: Double?
    let isUSMarketOpen: Bool?
}
