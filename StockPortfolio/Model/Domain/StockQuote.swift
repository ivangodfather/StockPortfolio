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
}
