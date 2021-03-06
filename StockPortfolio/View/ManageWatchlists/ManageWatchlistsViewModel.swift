//
//  WatchlistsViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 18/10/2020.
//

import Foundation
import SwiftUI
import Combine

final class ManageWatchlistsViewModel: ObservableObject {

    enum State {
        case loading
        case error(localizedError: String)
        case empty
        case loaded([Watchlist])
    }

    @Published var state = State.loading
    @Published var finishedSavingSymbol = false
    @Published var didDeleteWatchList: Watchlist?

    private let dataStorage: DataStorage
    private var cancellables = Set<AnyCancellable>()

    init(dataStorage: DataStorage = CoreDataStorage()) {
        self.dataStorage = dataStorage
    }

    func requestWatchlists() {
        state = .loading
        dataStorage.watchlists().sink { completion in
            if case let .failure(error) = completion  {
                self.state = .error(localizedError: error.localizedDescription)
            }
        } receiveValue: { watchlists in
            self.state = watchlists.isEmpty ? .empty : .loaded(watchlists)
        }.store(in: &cancellables)
    }

    func save(symbol: String, for watchlist: Watchlist) {
        dataStorage.save(symbol: symbol, for: watchlist).sink { completion in
            switch completion {
            case .failure(let error): print(error.localizedDescription)
            case .finished: self.finishedSavingSymbol = true
            }
        } receiveValue: { _ in }.store(in: &cancellables)

    }

    func delete(at offsets: IndexSet) {
        if case State.loaded(let watchlists) = state {
            state = .loading
            let watchlistsToRemove = offsets.map { watchlists[$0] }
            watchlistsToRemove.forEach { watchlistToRemove in
                dataStorage.remove(watchlist: watchlistToRemove).sink { completion in
                    switch completion {
                    case .finished:
                        self.didDeleteWatchList = watchlistToRemove
                        self.requestWatchlists()
                    case .failure(let error):
                        self.state = .error(localizedError: error.localizedDescription)
                    }
                } receiveValue: { _ in }.store(in: &cancellables)
            }
        }
    }
}
