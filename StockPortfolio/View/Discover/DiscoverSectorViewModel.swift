//
//  DiscoverSectorViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 05/10/2020.
//

import Foundation
import Combine

final class DiscoverSectorViewModel: ObservableObject {
    @Published var stocks: [IEXStock.Quote] = []

    private let api: API
    private var cancellables = Set<AnyCancellable>()

    init(api: API = API()) {
        self.api = api
    }

    func requestStocks(from sector: String, value: String) {
        api.collection(type: sector, value: value).sink { result in
            switch result {
            case .success(let stocks): self.stocks = stocks
            case .failure(let error): print(error.localizedDescription)
            }
        }.store(in: &cancellables)
    }
}
