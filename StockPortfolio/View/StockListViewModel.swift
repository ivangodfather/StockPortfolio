//
//  StocksViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class StockListViewModel: ObservableObject {

    @Published var stocks = [Stock]()

    private var cancellables = Set<AnyCancellable>()

    private let api: API
    private let dataStorage: DataStorage

    init(api: API = API(),
         dataStorage: DataStorage = CoreDataStorage()) {
        self.api = api
        self.dataStorage = dataStorage
    }

    func loadStocks() {
        dataStorage
            .get()
            .flatMap(self.api.stocks(from:))
            .sink { completion in }
                receiveValue: { result in
                    switch result {
                    case .success(let stocks): self.stocks = stocks
                    case.failure(let error): print(error.localizedDescription)
                    }
            }.store(in: &cancellables)
    }

    func addStock(symbol: String) {
        dataStorage.save(symbol: symbol)
            .sink { completion in
                self.loadStocks()
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
}
