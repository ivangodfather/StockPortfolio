//
//  CoreDataStorage.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import Foundation
import Combine

protocol DataStorage {
    func save(stock: Stock) -> AnyPublisher<Stock, DataStorageError>
    func get() -> AnyPublisher<[Stock], DataStorageError>
    func remove(symbol: String) -> AnyPublisher<(), DataStorageError>
    func watchlists() -> AnyPublisher<[Watchlist], DataStorageError>
}

enum DataStorageError: Error {
    case unkown(reason: String)
}
