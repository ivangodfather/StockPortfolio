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
    let company: Company

    var percentage: Double {
        latestPrice.percentage(from: previousClose)
    }

    struct Company {
        let exchange: String
        let industry: String
        let website: URL
        let ceo: String
        let description: String
        let securityName: String
        let issueType: IssueType
        let sector: String
        let employees: Int
        let tags: [String]
        let country: String
    }

    enum IssueType: String, Decodable {
        case cs = "cs" // Common Stock
        case et = "et" // Exchange Traded Fund (ETF)
        case wt = "wt" // Warrant
        case rt = "rt" // Right
        case re = "re" // Real Estate Investment Trust (REIT’s)
        case ad = "ad" // American Depository Receipt (ADR’s)
        case sc = "sc"
    }

}


