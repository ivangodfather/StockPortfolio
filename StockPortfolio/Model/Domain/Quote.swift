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
    let changePercent: Double
    let change: Double
    let latestUpdate: Date
    let marketCap: Double
    let extendedPrice: Double
    let extendedChange: Double
    let extendedChangePercent: Double
    let isUSMarketOpen: Bool
}

extension Quote: Identifiable {
    var id: String { symbol }

    var percentage: Double {
        latestPrice.percentage(from: previousClose)
    }

    var percentageString: String {
        percentage.round2() + "%"
    }

    var latestUpdateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: latestUpdate)
    }
}

extension Quote {
    init(quote: IEXQuote) {
        symbol = quote.symbol
        companyName = quote.companyName
        latestPrice = quote.latestPrice ?? 0
        previousClose = quote.previousClose ?? 0
        changePercent = quote.changePercent
        change = quote.change ?? 0
        latestUpdate = quote.latestUpdate != nil ? Date(timeIntervalSince1970: quote.latestUpdate! / 1000) : Date()
        marketCap = quote.marketCap ?? 0
        extendedPrice = quote.extendedPrice ?? 0
        extendedChange = quote.extendedPrice ?? 0
        extendedChangePercent = quote.extendedChangePercent ?? 0
        isUSMarketOpen = quote.isUSMarketOpen ?? false
    }

    static let random = Quote(symbol: "AMD",
                                    companyName: "Advanced Micro Devices Inc.",
                                    latestPrice: 27.30,
                                    previousClose: 90,
                                    changePercent: 1.19,
                                    change: 10.1, latestUpdate: Date(),
                                    marketCap: 1234,
                                    extendedPrice: 10,
                                    extendedChange: 2.5,
                                    extendedChangePercent: 0.27,
                                    isUSMarketOpen: false)
}
