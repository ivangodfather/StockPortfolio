//
//  AutocompleteResult.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 03/10/2020.
//

import Foundation

struct AutocompleteResult: Identifiable {
    let name: String
    let symbol: String
    var id: String { symbol }
}

extension AutocompleteResult {
    init(quote: RapidAPIQuote) {
        self.name = quote.shortname
        self.symbol = quote.symbol
    }
}
