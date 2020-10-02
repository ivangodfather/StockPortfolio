//
//  IEXNews.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 02/10/2020.
//

import Foundation

struct IEXNews: Decodable {
    let headline: String
    let source: String
    let url: URL
    let summary: String
    let image: String
}
