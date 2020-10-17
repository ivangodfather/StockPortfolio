//
//  CoreDataStorage+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation
import Combine

extension CoreDataStorage {
    func insertSampleData() -> AnyPublisher<[Stock], Never> {
        ["TSLA", "KO", "PEP", "AMD"]
            .publisher
            .map(Stock.init)
            .flatMap(save(stock:))
            .collect()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
