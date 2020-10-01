//
//  CoreDataStorage.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import Foundation
import Combine

protocol DataStorage {
    func save(symbol: String, shares: Int) -> AnyPublisher<(symbol: String, shares: Int), DataStorageError>
    func get() -> AnyPublisher<[(symbol: String, shares: Int)], DataStorageError>
    func remove(symbol: String) -> AnyPublisher<(), DataStorageError>
}

enum DataStorageError: Error {
    case unkown(reason: String)
}
