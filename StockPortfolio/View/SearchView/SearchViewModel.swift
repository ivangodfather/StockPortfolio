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
    @Published var autocompleteResults = [AutocompleteResult]()
    private let searchSubject = PassthroughSubject<String, Never>()

    private let api: API
    private var cancellables = Set<AnyCancellable>()

    init(api: API = API()) {
        self.api = api
        searchSubject
            .throttle(for: .seconds(0.5), scheduler: DispatchQueue.main, latest: false)
            .map(api.autcocomplete(from:))
            .switchToLatest()
            .sink { result in
                switch result {
                    case .success(let values):self.autocompleteResults = values
                    case .failure(let error): print(error.localizedDescription)
                }
            }.store(in: &cancellables)
    }

    func didSearch(_ term: String) {
        searchSubject.send(term)

    }
}
