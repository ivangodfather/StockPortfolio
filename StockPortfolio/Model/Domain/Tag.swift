//
//  Tag.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 04/10/2020.
//

import Foundation

struct Collection {
    let name: String
}

extension Collection {
    init(collection: IEXCollection) {
        name = collection.name
    }
}
