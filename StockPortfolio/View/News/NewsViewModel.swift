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

final class NewsViewModel: ObservableObject {

    enum State {
        case loading
        case loaded([News])
        case empty
        case error(String)
    }

    @Published var state: State  = .loading


    private var cancellables = Set<AnyCancellable>()
    private let numberOfNewsXItem = 3

    private let api: APIProtocol
    private let dataStorage: DataStorage

    init(api: APIProtocol = API(),
         dataStorage: DataStorage = CoreDataStorage()) {
        self.api = api
        self.dataStorage = dataStorage
    }

    func request() {
        state = .loading
        dataStorage
            .watchlists()
            .flatMap { $0.flatMap { $0.symbols }.publisher }
            .map { ($0 , self.numberOfNewsXItem) }
            .flatMap(api.news(from:items:))
            .map { try? $0.get() }
            .collect()
            .sink { (completion) in
                switch completion {
                case .finished: break
                case .failure(let error): self.state = .error(error.localizedDescription)
                }
            } receiveValue: { result in
                let news = result.compactMap { $0 }.flatMap { $0 }.sorted(by: >)
                self.state = news.isEmpty ? .empty : .loaded(news)
            }.store(in: &cancellables)
    }


}
