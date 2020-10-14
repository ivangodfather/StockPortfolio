//
//  StockDetailViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 05/10/2020.
//

import Foundation
import SwiftUI
import Combine

final class CompanyViewModel: ObservableObject {

    enum State {
        case loaded(CompanyDetail)
        case loading
        case error(String)
    }

    @Published var state: State = .loading

    private let api: APIProtocol
    private var cancellables = Set<AnyCancellable>()

    init(api: APIProtocol = API()) {
        self.api = api
    }

    func requestCompanyData(from symbol: String) {
        api.companyDetail(from: symbol)
            .sink { result in
                switch result {
                case .success(let companyDetail):
                    self.state = .loaded(companyDetail)
                case .failure(let error):
                    self.state = .error(error.localizedDescription)
                }
            }.store(in: &cancellables)
    }
}
