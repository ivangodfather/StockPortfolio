//
//  PortfolioViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 06/10/2020.
//

import Foundation
import Combine

final class PortfolioViewModel: ObservableObject {

    @Published var quotes: [QuoteDetail] = []
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
                case.success(let quotes):
                    self.quotes = quotes
                case .failure(let error): print(error.localizedDescription)
                }
            }.store(in: &cancellables)
    }


    func deleteQuote(at offsets: IndexSet) {
        let symbols = offsets.map { quotes[$0].quote.symbol }
        symbols.publisher.flatMap(dataStorage.remove(symbol:)).sink { completion in
            switch completion {
            case.finished:
                self.quotes.removeAll { symbols.contains($0.quote.symbol) }
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
