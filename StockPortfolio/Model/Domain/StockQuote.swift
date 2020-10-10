//
//  StockQuote.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 08/10/2020.
//

import Foundation

struct StockQuote: Identifiable {
    let quote: Quote
    var numberOfShares: Int

    var id: String {
        quote.symbol
    }

    var currentValueString: String {
        (quote.latestPrice * Double(numberOfShares)).round2()
    }

    var totalGainLoss: String {
        let symbol = quote.gainLoss > 0 ? "+" : ""
        return symbol + (quote.gainLoss * Double(numberOfShares)).round2()
    }
}
