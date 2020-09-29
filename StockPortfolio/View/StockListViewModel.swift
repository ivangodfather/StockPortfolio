//
//  StocksViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation
import SwiftUI
import Combine

class StockListViewModel: ObservableObject {

    @Published var stocks = [Stock]()

    private var symbols = [String]() {
        didSet {
            loadStocks()
        }
    }

    private let api: API
    private var cancellables = Set<AnyCancellable>()

    init(api: API = API()) {
        self.api = api
    }

    func loadStocks() {
        api.stocks(from: symbols).sink { result in
            switch result {
                case .success(let stocks):
                    self.stocks = stocks
                case .failure(let error): print(error.localizedDescription)
            }
        }.store(in: &cancellables)
    }

    func addStock(symbol: String) {
        symbols.append(symbol)
    }
}
