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

    func save(stock: Stock) -> AnyPublisher<Stock, DataStorageError> {
        let entityName = String(describing: StockCoreData.self)
        guard let entity = NSEntityDescription
                .insertNewObject(forEntityName: entityName, into: manager.context) as? StockCoreData else {
            return Fail(outputType: Stock.self,
                        failure: DataStorageError.unkown(reason: "invalid schema")).eraseToAnyPublisher()
        }
        entity.symbol = stock.symbol
        do {
            try manager.context.save()
            return Just(stock).setFailureType(to: DataStorageError.self).eraseToAnyPublisher()
        } catch {
            return Fail(outputType: Stock.self,
                        failure: DataStorageError.unkown(reason: error.localizedDescription)).eraseToAnyPublisher()
        }
    }

    func get() -> AnyPublisher<[Stock], DataStorageError> {
        let request: NSFetchRequest<StockCoreData> = StockCoreData.fetchRequest()
        do {
            let stocks = try PersistenceManager.shared.context.fetch(request)
            let elements = stocks.map { $0.symbol ?? "" }.map(Stock.init(symbol:))
            return Just(elements).setFailureType(to: DataStorageError.self).eraseToAnyPublisher()
        } catch {
            let failure = DataStorageError.unkown(reason: error.localizedDescription)
            return Fail(outputType: [Stock].self, failure: failure).eraseToAnyPublisher()
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
            let failure = DataStorageError.unkown(reason: error.localizedDescription)
            return Fail(outputType: Void.self, failure: failure).eraseToAnyPublisher()
        }
    }

}
