//
//  Stock.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation

struct Quote {
    let symbol: String
    let companyName: String
    let latestPrice: Double
    let previousClose: Double
    let logo: URL

    var percentage: Double {
        latestPrice.percentage(from: previousClose)
    }

}

extension Quote: Identifiable {
    var id: String { symbol }
}

extension Quote {
    init(iexQuote: IEXQuote) {
        symbol = iexQuote.quote.symbol
        companyName = iexQuote.quote.companyName
        latestPrice = iexQuote.quote.latestPrice ?? 0
        previousClose = iexQuote.quote.previousClose ?? 0
        logo = iexQuote.logo.url
    }

    init(quote: IEXQuote.Quote, iexLogo: IEXLogo) {
        symbol = quote.symbol
        companyName = quote.companyName
        latestPrice = quote.latestPrice ?? 0
        previousClose = quote.previousClose ?? 0
        logo = iexLogo.url
    }
}

