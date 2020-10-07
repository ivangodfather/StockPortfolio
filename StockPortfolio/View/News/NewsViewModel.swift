//
//  NewsViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 02/10/2020.
//


import Foundation
import SwiftUI
import Combine
import CoreData

class NewsViewModel: ObservableObject {

    @Published var news = [News]()

    private var cancellables = Set<AnyCancellable>()
    private let numberOfNewsXItem = 3

    private let api: APIProtocol

    init(api: APIProtocol = API()) {
        self.api = api
    }

    func request(symbols: [String]) {
        symbols
            .publisher
            .map { ($0, numberOfNewsXItem) }
            .flatMap(api.news(from:items:))
            .collect()
            .sink { result in
                self.news = result.compactMap { try? $0.get() }.flatMap { $0 }
            }.store(in: &cancellables)
    }
}
