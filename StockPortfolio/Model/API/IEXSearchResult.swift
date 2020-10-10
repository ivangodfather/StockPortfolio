//
//  RapidAPIAutocomplete.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 03/10/2020.
//

import Foundation

struct IEXSearchResult: Decodable {
    let securityName: String
    let symbol: String
    let exchange: String
}

struct IEXSearchResultResponse: Decodable {
    let values: [IEXSearchResult]
}
