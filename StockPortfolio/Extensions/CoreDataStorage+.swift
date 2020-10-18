//
//  CoreDataStorage+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation
import Combine

extension CoreDataStorage {
    func insertSampleData() -> AnyPublisher<Watchlist, Never> {
      createWatchlist(name: "My Stocks")
            .flatMap { watchlist in
                ["TSLA", "KO", "PEP", "AMD"].map { ($0, watchlist) }.publisher
            }.flatMap(save(symbol:for:))
            .collect()
            .map { $0.first! }
            .replaceError(with: .empty)
            .eraseToAnyPublisher()
    }
}
