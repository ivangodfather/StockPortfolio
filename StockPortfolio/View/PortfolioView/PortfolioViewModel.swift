//
//  PortfolioViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 06/10/2020.
//

import Foundation
import Combine

final class PortfolioViewModel: ObservableObject {

    @Published var stockQuotes: [StockQuote] = [] {
        didSet { updatePortfolioValue() }
    }
    @Published var portfolioValue: PortfolioValue? = nil
    @Published var hasNoStocks = false

    private var cancellables = Set<AnyCancellable>()
    private let api: APIProtocol
    private let dataStorage: DataStorage

    init(api: APIProtocol = API(),
         dataStorage: DataStorage = CoreDataStorage()) {
        self.api = api
        self.dataStorage = dataStorage
    }

    func loadQuotes() {
        dataStorage
            .get()
            .handleEvents(receiveOutput: { stocks in
                self.hasNoStocks = stocks.isEmpty
            })
            .flatMap { stocks in
                self.api.quoteDetails(from: stocks.map { $0.symbol }).map { ($0, stocks) }
            }
            .sink { _ in
            } receiveValue: { (quoteDetailResult, stocks) in
                switch quoteDetailResult {
                case.success(let quoteDetails):
                    self.stockQuotes = stocks.map { stock in
                        (quoteDetails.first { stock.symbol == $0.quote.symbol }!, stock.shares)
                    }.map(StockQuote.init)
                case .failure(let error): print(error.localizedDescription)
                }
            }.store(in: &cancellables)
    }

    private func updatePortfolioValue() {
        dataStorage
            .get()
            .sink { _ in
            } receiveValue: { stocks in
                self.portfolioValue = PortfolioValueUseCase.value(from: self.stockQuotes)
            }.store(in: &cancellables)
    }


    func deleteQuote(at offsets: IndexSet) {
        let symbols = offsets.map { stockQuotes[$0].quoteDetail.quote.symbol }
        symbols.publisher.flatMap(dataStorage.remove(symbol:)).sink { completion in
            switch completion {
            case.finished:
                self.stockQuotes.removeAll { symbols.contains($0.quoteDetail.quote.symbol) }
            case.failure(let error): print(error.localizedDescription)
            }
        } receiveValue: { _ in }.store(in: &cancellables)
    }

    func insertSampleData() {
        CoreDataStorage().insertSampleData().sink { _ in
            self.loadQuotes()
        }.store(in: &cancellables)
    }
}
