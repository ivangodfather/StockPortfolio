//
//  CoreDataStorage+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation
import Combine

extension CoreDataStorage {
    func insertSampleData() -> AnyPublisher<[(symbol: String, shares: Int)], Never> {
        [("TSLA", 5), ("KO", 25), ("PEP", 43), ("AMD", 15)]
            .publisher
            .flatMap(save(symbol:shares:))
            .collect()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
