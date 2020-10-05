//
//  CollectionType.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 04/10/2020.
//

import Foundation

enum CollectionType: Int, CaseIterable, CustomStringConvertible {
    case sector = 0
    case tags

    var description: String {
        switch self {
        case .sector: return "Sectors"
        case .tags: return "Tags"
        }
    }
}
