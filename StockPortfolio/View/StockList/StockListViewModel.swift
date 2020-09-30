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
    @Published var portfolioValue: PortfolioValue?

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
            .flatMap { symbols -> AnyPublisher<[String], Never> in
                if symbols.isEmpty {
                    return CoreDataStorage().insertSampleData()
                }
                return Just(symbols).eraseToAnyPublisher()
            }
            .flatMap(self.api.stocks(from:))
            .sink { completion in }
                receiveValue: { result in
                    switch result {
                    case .success(let stocks):
                        self.stocks = stocks
                        self.setPotfolioValue()
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

    func deleteStock(at offsets: IndexSet) {
        let symbols = offsets.map { stocks[$0].symbol }
        symbols.publisher.flatMap(dataStorage.remove(symbol:)).sink { completion in
            switch completion {
            case.finished: self.stocks.removeAll { symbols.contains($0.symbol) }
            case.failure(let error): print(error.localizedDescription)
            }
        } receiveValue: { _ in }.store(in: &cancellables)
    }

    private func setPotfolioValue() {
        // This is random
        portfolioValue = PortfolioValue(portfolioTotalValue: Int.random(in: 1500...15000),
                                        portfolioFractionalValue: Int.random(in: 21...80),
                                        portfolioTodayGain: Int.random(in: 800...900),
                                        portfolioPercentage: Double.random(in: 0...2))
    }
}
