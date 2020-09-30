//
//  CoreDataStorage.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import Foundation
import Combine

protocol DataStorage {
    func save(symbol: String) -> AnyPublisher<String, DataStorageError>
    func get() -> AnyPublisher<[String], DataStorageError>
    func remove(symbol: String) -> AnyPublisher<(), DataStorageError>
}

enum DataStorageError: Error {
    case unkown(reason: String)
}
