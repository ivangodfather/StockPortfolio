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
    let changePercent: String
}

extension Quote: Identifiable {
    var id: String { symbol }

    var percentage: Double {
        latestPrice.percentage(from: previousClose)
    }

    var gainLoss: Double {
        latestPrice - previousClose
    }

    var gainLossString: String {
        let symbol = gainLoss > 0 ? "+" : ""
        return symbol + gainLoss.round2()
    }
}

extension Quote {
    init(quote: IEXQuote) {
        symbol = quote.symbol
        companyName = quote.companyName
        latestPrice = quote.latestPrice ?? 0
        previousClose = quote.previousClose ?? 0
        changePercent = (quote.changePercent * 100).round2()
    }

    static let random = Quote(symbol: "AMD",
                                    companyName: "Advanced Micro Devices Inc.",
                                    latestPrice: 100,
                                    previousClose: 90,
                                    changePercent: "-1.19")
}
