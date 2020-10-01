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

    @Published var stocks = [StockDetail]() {
        didSet { portfolioValue = PortfolioValueUseCase.value(from: self.stocks) }
    }
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
            .flatMap { stocks -> AnyPublisher<[Stock], Never> in
                if stocks.isEmpty {
                    return CoreDataStorage().insertSampleData()
                }
                return Just(stocks).eraseToAnyPublisher()
            }
            .flatMap(self.api.stocks(from:))
            .sink { completion in }
                receiveValue: { result in
                    switch result {
                    case .success(let stocks):
                        self.stocks = stocks
                    case.failure(let error): print(error.localizedDescription)
                    }
            }.store(in: &cancellables)
    }

    func addStock(symbol: String, shares: String) {
        guard let intShares = Int(shares) else { return }
        dataStorage.save(stock: Stock(symbol: symbol, shares: intShares))
            .sink { completion in
                self.loadStocks()
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }

    func deleteStock(at offsets: IndexSet) {
        let symbols = offsets.map { stocks[$0].symbol }
        symbols.publisher.flatMap(dataStorage.remove(symbol:)).sink { completion in
            switch completion {
            case.finished:
                self.stocks.removeAll { symbols.contains($0.symbol) }
            case.failure(let error): print(error.localizedDescription)
            }
        } receiveValue: { _ in }.store(in: &cancellables)
    }
}

struct PortfolioValueUseCase {
    static func value(from stocks: [StockDetail]) -> PortfolioValue {
        let total = stocks.map { $0.latestPrice * Double($0.shares) }.reduce(0,+)
        let fractional = String(modf(total).1.description.prefix(4).suffix(2))
        return PortfolioValue(portfolioTotalValue: Int(total), portfolioFractionalValue: fractional, portfolioTodayGain: 3, portfolioPercentage: 3.55)
    }
}
