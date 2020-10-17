//
//  AddStockViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 03/10/2020.
//

import Foundation
import SwiftUI
import Combine

final class AddStockViewModel: ObservableObject {

    private let dataStorage: DataStorage
    private var cancellables = Set<AnyCancellable>()
    init(dataStorage: DataStorage = CoreDataStorage()) {
        self.dataStorage = dataStorage
    }

    let didFinishPublisher = PassthroughSubject<Stock, Never>()

    func addStock(symbol: String, shares: String) {
        dataStorage
            .save(stock: Stock(symbol: symbol))
            .sink { completion in
            } receiveValue: { [weak self] stock in
                self?.didFinishPublisher.send(stock)
            }
            .store(in: &cancellables)
    }
}
