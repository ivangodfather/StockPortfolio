//
//  NewWatchlistViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 18/10/2020.
//

import Foundation
import Combine

final class NewWatchlistViewModel: ObservableObject {

    private let dataStorage: DataStorage
    @Published var watchlistCreated = false
    private var cancellables = Set<AnyCancellable>()

    init(dataStorage: DataStorage = CoreDataStorage()) {
        self.dataStorage = dataStorage
    }

    func saveWatchlist(name: String) {
        dataStorage.createWatchlist(name: name).sink { completion in
            switch completion {
            case .failure(let error): print(error.localizedDescription)
            case .finished: self.watchlistCreated = true
            }
        } receiveValue: { _ in}.store(in: &cancellables)
    }
}
