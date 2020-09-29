//
//  IEXResponse.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation

struct IEXStock: Decodable {
    let quote: Quote
    let logo: Logo

    struct Quote: Decodable {
        let symbol: String
        let companyName: String
        let latestPrice: Double
        let previousClose: Double
    }

    struct Logo: Decodable {
        let url: URL
    }
}

extension Stock {
    init(iexStock: IEXStock) {
        symbol = iexStock.quote.symbol
        companyName = iexStock.quote.companyName
        latestPrice = iexStock.quote.latestPrice
        previousClose = iexStock.quote.previousClose
        logo = iexStock.logo.url
    }
}
