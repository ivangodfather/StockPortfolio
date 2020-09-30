//
//  CoreDataStorage+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation
import Combine

extension CoreDataStorage {
    func insertSampleData() -> AnyPublisher<[String], Never> {
        ["TSLA", "KO", "PEP", "AMD"]
            .publisher
            .flatMap(save(symbol:))
            .collect()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
