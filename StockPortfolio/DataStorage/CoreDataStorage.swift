//
//  DataStorage.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import Foundation
import CoreData
import Combine

class CoreDataStorage: DataStorage {

    private let manager: PersistenceManager
    private var cancellables = Set<AnyCancellable>()

    init(manager: PersistenceManager = PersistenceManager.shared) {
        self.manager = manager
    }

    func save(symbol: String, shares: Int) -> AnyPublisher<(symbol: String, shares: Int), DataStorageError> {
        let entity = NSEntityDescription.insertNewObject(forEntityName: String(describing: StockCoreData.self), into: manager.context) as! StockCoreData
        entity.symbol = symbol
        entity.shares = Int64(shares)
        do {
            try manager.context.save()
            return Just((symbol, shares)).setFailureType(to: DataStorageError.self).eraseToAnyPublisher()
        } catch {
            return Fail(outputType: (symbol: String, shares: Int).self,
                        failure: DataStorageError.unkown(reason: error.localizedDescription)).eraseToAnyPublisher()
        }
    }

    func get() -> AnyPublisher<[(symbol: String, shares: Int)], DataStorageError> {
        let request: NSFetchRequest<StockCoreData> = StockCoreData.fetchRequest()
        do {
            let stocks = try PersistenceManager.shared.context.fetch(request)
            let elements = stocks.map { ($0.symbol ?? "", Int($0.shares)) }.filter { $0.0 != "" }
            return Just(elements).setFailureType(to: DataStorageError.self).eraseToAnyPublisher()
        } catch {
            return Fail(outputType: [(symbol: String, shares: Int)].self, failure: DataStorageError.unkown(reason: error.localizedDescription)).eraseToAnyPublisher()
        }
    }

    func remove(symbol: String) -> AnyPublisher<(), DataStorageError> {
        let request: NSFetchRequest<StockCoreData> = StockCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(StockCoreData.symbol), symbol])
        do {
            let results = try manager.context.fetch(request)
            results.forEach {
                manager.context.delete($0)
            }
            try manager.context.save()
            return Just(()).setFailureType(to: DataStorageError.self).eraseToAnyPublisher()
        } catch {
            return Fail(outputType: Void.self, failure: DataStorageError.unkown(reason: error.localizedDescription)).eraseToAnyPublisher()
        }
    }

}
