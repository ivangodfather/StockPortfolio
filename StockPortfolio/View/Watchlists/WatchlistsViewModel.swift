//
//  WatchlistsViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 18/10/2020.
//

import Foundation
import SwiftUI
import Combine

final class WatchlistsViewModel: ObservableObject {

    enum State {
        case loading
        case error(localizedError: String)
        case loaded([Watchlist])
    }

    @Published var state = State.loading

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
            self.state = .loaded(watchlists)
        }.store(in: &cancellables)
    }
}
