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

    func createWatchlist(name: String) -> AnyPublisher<Watchlist, DataStorageError> {
        guard watchlist(name: name) == nil else {
            return Fail(error: DataStorageError.watchlistAlreadyExists).eraseToAnyPublisher()
        }
        let entitiyName = String(describing: CoreDataWatchlist.self)
        guard let entitiy = NSEntityDescription.insertNewObject(forEntityName: entitiyName, into: manager.context) as? CoreDataWatchlist else {
                        return Fail(outputType: Watchlist.self,
                                    failure: DataStorageError.unkown(reason: "invalid schema"))
                            .eraseToAnyPublisher()
        }
        entitiy.name = name
        do {
            try manager.context.save()
            return Just(Watchlist(coredata: entitiy)).setFailureType(to: DataStorageError.self).eraseToAnyPublisher()
        } catch {
            return Fail(outputType: Watchlist.self,
                        failure: DataStorageError.unkown(reason: error.localizedDescription)).eraseToAnyPublisher()
        }
    }

    func remove(symbol: String, in watchlist: Watchlist) -> AnyPublisher<(), DataStorageError> {
        let request: NSFetchRequest<CoreDataWatchlist> = CoreDataWatchlist.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(CoreDataWatchlist.name), watchlist.name])
        do {
            let results = try manager.context.fetch(request)
            results.forEach { watchlist in
                var symbols = watchlist.symbols ?? []
                symbols.removeAll { $0 == symbol }
                watchlist.symbols = symbols
            }
            try manager.context.save()
            return Just(()).setFailureType(to: DataStorageError.self).eraseToAnyPublisher()
        } catch {
            let failure = DataStorageError.unkown(reason: error.localizedDescription)
            return Fail(outputType: Void.self, failure: failure).eraseToAnyPublisher()
        }
    }

    func save(symbol: String, for watchlist: Watchlist) -> AnyPublisher<Watchlist, DataStorageError> {
        let request: NSFetchRequest<CoreDataWatchlist> = CoreDataWatchlist.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(CoreDataWatchlist.name), watchlist.name)
        do {
            let result = try manager.context.fetch(request)
            if let list = result.first {
                list.symbols = [symbol] + (list.symbols ?? [])
                try manager.context.save()
                return Just(Watchlist(coredata: list)).setFailureType(to: DataStorageError.self).eraseToAnyPublisher()
            }
            return Fail(outputType: Watchlist.self,
                        failure: DataStorageError.unkown(reason: "Couldn't find watchlist")).eraseToAnyPublisher()

        } catch {
            return Fail(outputType: Watchlist.self,
                        failure: DataStorageError.unkown(reason: "invalid schema")).eraseToAnyPublisher()
        }
    }

    func watchlists() -> AnyPublisher<[Watchlist], DataStorageError> {
        let fetchRequest: NSFetchRequest<CoreDataWatchlist> = CoreDataWatchlist.fetchRequest()
        do {
            let results = try manager.context.fetch(fetchRequest)
            let watchlists = results.map(Watchlist.init(coredata:))
            return Just(watchlists).setFailureType(to: DataStorageError.self).eraseToAnyPublisher()
        } catch {
            return Fail(outputType: [Watchlist].self,
                        failure: DataStorageError.unkown(reason: "invalid schema")).eraseToAnyPublisher()
        }
    }

    func remove(watchlist: Watchlist) -> AnyPublisher<(), DataStorageError> {
        let request: NSFetchRequest<CoreDataWatchlist> = CoreDataWatchlist.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(CoreDataWatchlist.name), watchlist.name])
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

    func watchlist(name: String) -> CoreDataWatchlist? {
        let request: NSFetchRequest<CoreDataWatchlist> = CoreDataWatchlist.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(CoreDataWatchlist.name), name)
        return try? manager.context.fetch(request).first
    }

}
