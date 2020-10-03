//
//  RapidAPIAutocomplete.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 03/10/2020.
//

import Foundation

struct RapidAPIQuote: Decodable {
    let shortname: String
    let symbol: String
}

struct RapidAPIAutocompleteResponse: Decodable {
    let quotes: [RapidAPIQuote]
}
