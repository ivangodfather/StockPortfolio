//
//  SearchViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 03/10/2020.
//

import Foundation
import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    private let searchSubject = PassthroughSubject<String, Never>()

    private let api: APIProtocol
    private var cancellables = Set<AnyCancellable>()

    enum State {
        case initial
        case loading
        case results([QuoteDetail])
        case error(String)
    }

    @Published var state = State.initial

    init(api: APIProtocol = API()) {
        self.api = api
        searchSubject
            .handleEvents(receiveOutput: { _ in
                self.state = .loading
            })
            .throttle(for: .seconds(0.5), scheduler: DispatchQueue.main, latest: false)
            .map(api.search(from:))
            .switchToLatest()
            .tryMap { try $0.get() }
            .map { $0.map { $0.symbol }}
            .flatMap(api.quoteDetails(from:))
            .eraseToAnyPublisher()
            .sink { (completion) in
            } receiveValue: { result in
                switch result {
                case .success(let quoteDetails): self.state = .results(quoteDetails)
                case .failure(let error): self.state = .error(error.localizedDescription)
                }
            }.store(in: &cancellables)

    }

    func didSearch(_ term: String) {
        searchSubject.send(term)

    }
}
