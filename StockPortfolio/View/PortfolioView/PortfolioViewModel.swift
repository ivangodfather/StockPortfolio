//
//  PortfolioViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 06/10/2020.
//

import Foundation
import Combine

final class PortfolioViewModel: ObservableObject {

    @Published var quotes: [Quote] = []

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
            .map { $0.map { $0.symbol }}
            .flatMap(api.quotes(from:))
            .sink { _ in
            } receiveValue: { result in
                switch result {
                case.success(let quotes): self.quotes = quotes
                case .failure(let error): print(error.localizedDescription)
                }
            }.store(in: &cancellables)
    }


    func deleteQuote(at offsets: IndexSet) {
        let symbols = offsets.map { quotes[$0].symbol }
        symbols.publisher.flatMap(dataStorage.remove(symbol:)).sink { completion in
            switch completion {
            case.finished:
                self.quotes.removeAll { symbols.contains($0.symbol) }
            case.failure(let error): print(error.localizedDescription)
            }
        } receiveValue: { _ in }.store(in: &cancellables)
    }
}
