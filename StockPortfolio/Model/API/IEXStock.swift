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
        let latestPrice: Double?
        let previousClose: Double?
    }

    struct Logo: Decodable {
        let url: URL
    }

}

extension StockDetail {
    init(iexStock: IEXStock, shares: Int) {
        symbol = iexStock.quote.symbol
        self.shares = shares
        companyName = iexStock.quote.companyName
        latestPrice = iexStock.quote.latestPrice ?? 0
        previousClose = iexStock.quote.previousClose ?? 0
        logo = iexStock.logo.url
    }
}
