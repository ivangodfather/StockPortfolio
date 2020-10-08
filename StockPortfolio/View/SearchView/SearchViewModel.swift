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
        case results([AutocompleteResult])
        case error(Error)
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
            .sink { result in
                switch result {
                case .success(let values): self.state = .results(values)
                case .failure(let error): self.state = .error(error)
                }
            }.store(in: &cancellables)
    }

    func didSearch(_ term: String) {
        searchSubject.send(term)

    }
}
