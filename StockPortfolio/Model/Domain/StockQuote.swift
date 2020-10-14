//
//  StockQuote.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 08/10/2020.
//

import Foundation

struct StockQuote: Identifiable {
    let quoteDetail: QuoteDetail
    var numberOfShares: Int

    var id: String {
        quoteDetail.quote.symbol
    }

    var currentValueString: String {
        (quoteDetail.quote.latestPrice * Double(numberOfShares)).round2()
    }

    var totalGainLoss: String {
        let symbol = quoteDetail.quote.gainLoss > 0 ? "+" : ""
        return symbol + (quoteDetail.quote.gainLoss * Double(numberOfShares)).round2()
    }
}

extension StockQuote {
    static let random = StockQuote(quoteDetail: .random, numberOfShares: 5)
}
