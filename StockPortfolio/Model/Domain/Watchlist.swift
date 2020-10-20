//
//  Watchlist.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 18/10/2020.
//

import Foundation

struct Watchlist: Identifiable, Equatable {
    let name: String
    let symbols: [String]

    var isEmpty: Bool { symbols.isEmpty }
    var id: String { name }
}

extension Watchlist {
    init(coredata: CoreDataWatchlist) {
        self.name = coredata.name ?? ""
        self.symbols = coredata.symbols ?? []
    }

    static let empty = Watchlist(name: "My Stocks", symbols: [])
}
