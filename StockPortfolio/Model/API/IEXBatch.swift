//
//  IEXResponse.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation

struct IEXBatch: Decodable {

    let quote: Quote
    let logo: IEXLogo

    struct Quote: Decodable {
        let symbol: String
        let companyName: String
        let latestPrice: Double?
        let previousClose: Double?
        let changePercent: Double
    }
}
