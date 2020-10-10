//
//  AutocompleteResult.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 03/10/2020.
//

import Foundation

struct SearchResult: Identifiable {
    let name: String
    let symbol: String
    let exchange: String
    var id: String { symbol }
}

extension SearchResult {
    init(searchResult: IEXSearchResult) {
        name = searchResult.securityName
        symbol = searchResult.symbol
        exchange = searchResult.exchange
    }
}
