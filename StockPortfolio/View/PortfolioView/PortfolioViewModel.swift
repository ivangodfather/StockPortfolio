//
//  PortfolioViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 06/10/2020.
//

import Foundation
import Combine

final class PortfolioViewModel: ObservableObject {

    @Published var watchLists: [Watchlist] = []
    @Published var quotes: [QuoteDetail] = []

    var selectedWatchlist: Watchlist? = nil

    private var cancellables = Set<AnyCancellable>()
    private let api: APIProtocol
    private let dataStorage: DataStorage

    init(api: APIProtocol = API(),
         dataStorage: DataStorage = CoreDataStorage()) {
        self.api = api
        self.dataStorage = dataStorage
    }

    func loadWatchlists() {
        dataStorage
            .watchlists()
            .flatMap { watchlists -> AnyPublisher<[Watchlist], Never> in
                if watchlists.isEmpty {
                    return self.dataStorage
                        .createWatchlist(name: "My Stocks")
                        .map { [$0] }
                        .replaceError(with: []).eraseToAnyPublisher()
                }
                return Just(watchlists).eraseToAnyPublisher()
            }.sink { completion in
                switch completion {
                case.finished: break
                case .failure(let error): print(error.localizedDescription)
                }
            } receiveValue: { watchLists in
                self.watchLists = watchLists
                if let first = watchLists.first {
                    self.loadQuotes(from: first)
                }
            }.store(in: &cancellables)

    }

    func loadQuotes(from watchlist: Watchlist) {
        self.api.quoteDetails(from: watchlist.symbols)
            .sink { _ in
            } receiveValue: { quoteDetailResult in
                switch quoteDetailResult {
                case.success(let quotes):
                    self.quotes = quotes
                case .failure(let error): print(error.localizedDescription)
                }
            }.store(in: &cancellables)
    }


    func deleteQuote(at offsets: IndexSet) {
        if let watchlist = selectedWatchlist {
            let symbols = offsets.map { quotes[$0].quote.symbol }
            symbols
                .publisher
                .map { ($0, watchlist) }
                .flatMap(dataStorage.remove(symbol:in:))
                .sink { completion in
                    switch completion {
                    case .finished: self.quotes.removeAll { symbols.contains($0.quote.symbol) }
                    case .failure(let error): print(error.localizedDescription)
                    }
                } receiveValue: { _ in
                }.store(in: &cancellables)

        }
    }

    func insertSampleData() {
        CoreDataStorage().insertSampleData().sink {
            self.loadQuotes(from: $0)
        }.store(in: &cancellables)
    }
}
