//
//  AutoComplete.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 12/10/2020.
//

import Foundation

struct RapidAPIAutocompleteResponse: Decodable {
    let quotes: [Quote]

    struct Quote: Decodable {
        let shortname: String
        let symbol: String
        let exchange: String
    }
}
