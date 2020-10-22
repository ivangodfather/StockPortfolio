//
//  WatchlistsViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 06/10/2020.
//

import Foundation
import Combine

final class WatchlistsViewModel: ObservableObject {

    private var selectedWatchlist: Watchlist? = nil {
        didSet {
            watchlistName = selectedWatchlist?.name ?? "Watchlist"
        }
    }

    @Published var watchlistName = "Watchlist"

    enum State {
        case initial
        case emptyWatchlists
        case error(String)
        case loading
        case emptySymbols
        case loadedWatchList(quotes: [QuoteDetail])
    }
    @Published var state: State = .initial

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
                    self.state = .emptyWatchlists
                    return Empty(completeImmediately: true).eraseToAnyPublisher()
                }
                return Just(watchlists).eraseToAnyPublisher()
            }.sink { completion in
                switch completion {
                case.finished: break
                case .failure(let error): self.state = .error(error.localizedDescription)
                }
            } receiveValue: { watchLists in
                self.selectedWatchlist = watchLists.first
                self.loadQuotes()
            }.store(in: &cancellables)

    }

    func loadQuotes() {
        guard let watchlist = selectedWatchlist else { return }
        state = .loading
        guard !watchlist.symbols.isEmpty else {
            state = .emptySymbols
            return
        }
        self.api.quoteDetails(from: watchlist.symbols)
            .sink { _ in
            } receiveValue: { quoteDetailResult in
                switch quoteDetailResult {
                case.success(let quotes):
                    self.state = .loadedWatchList(quotes: quotes)
                case .failure(let error): self.state = .error(error.localizedDescription)
                }
            }.store(in: &cancellables)
    }

    func didDeleteWatchlist(_ watchlist: Watchlist) {
        if selectedWatchlist == watchlist {
            loadWatchlists()
        }
    }

    func didSelect(_ watchlist: Watchlist) {
        self.selectedWatchlist = watchlist
        self.loadQuotes()
    }


    func deleteQuote(at offsets: IndexSet) {
        if case let State.loadedWatchList(quotes) = state, let watchlist = selectedWatchlist  {
            let symbolsToDelete = offsets.map { quotes[$0].quote.symbol }
            symbolsToDelete
                .publisher
                .map { ($0, watchlist) }
                .flatMap(dataStorage.remove(symbol:in:))
                .sink { completion in
                    switch completion {
                    case .finished:
                        let symbols = Set(watchlist.symbols).subtracting(symbolsToDelete)
                        self.selectedWatchlist = Watchlist(name: watchlist.name, symbols: Array(symbols))
                        var newQuotes = quotes
                        symbolsToDelete.forEach { symbol in
                            newQuotes.removeAll(where: { $0.quote.symbol == symbol })
                        }
                        self.state = .loadedWatchList(quotes: newQuotes)
                    case .failure(let error): print(error.localizedDescription)
                    }
                } receiveValue: { _ in
                }.store(in: &cancellables)

        }
    }

    func insertSampleData() {
        CoreDataStorage().insertSampleData().sink {
            self.selectedWatchlist = $0
            self.loadQuotes()
        }.store(in: &cancellables)
    }
}
