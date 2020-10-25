//
//  CoreDataStorage.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import Foundation
import Combine

protocol DataStorage {
    func save(symbol: String, for watchlist: Watchlist) -> AnyPublisher<Watchlist, DataStorageError>
    func remove(symbol: String, in watchlist: Watchlist) -> AnyPublisher<(), DataStorageError>
    func watchlists() -> AnyPublisher<[Watchlist], DataStorageError>
    func createWatchlist(name: String) -> AnyPublisher<Watchlist, DataStorageError>
    func remove(watchlist: Watchlist) -> AnyPublisher<(), DataStorageError>
}

enum DataStorageError: Error {
    case unkown(reason: String)
    case watchlistAlreadyExists
    case symbolAlreadyExists
}
