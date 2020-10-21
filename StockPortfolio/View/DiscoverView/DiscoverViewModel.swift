//
//  DiscoverViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 04/10/2020.
//

import Foundation
import SwiftUI
import Combine

final class DiscoverViewModel: ObservableObject {
    enum State {
        case loading
        case loaded([QuoteDetail])
        case error(String)
    }
    @Published var state: State = .loading

    private var cancellables = Set<AnyCancellable>()
    private let api: APIProtocol

    init(api: APIProtocol = API()) {
        self.api = api
    }

    func request(listIndex: Int) {
        guard let listType = ListType(rawValue: listIndex) else { return }
        state = .loading
        api
            .marketInfo(listType: listType.apiDescription)
            .sink { result in
                switch result {
                case .success(let quotesDetails):
                    self.state = .loaded(quotesDetails)
                case.failure(let error):
                    self.state = .error(error.localizedDescription)
                }
            }.store(in: &cancellables)
    }
}
