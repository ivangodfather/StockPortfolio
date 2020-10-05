//
//  StockDetailViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 05/10/2020.
//

import Foundation
import SwiftUI
import Combine

final class StockDetailViewModel: ObservableObject {


    @Published var company: Company?
    @Published var logoURL: URL?

    private let api: API
    private var cancellables = Set<AnyCancellable>()

    init(api: API = API()) {
        self.api = api
    }

    func requestCompanyData(from symbol: String) {
        Publishers.Zip(api.company(from: symbol), api.logo(from: symbol)).sink { (companyResult, urLogoResult) in
            switch (companyResult, urLogoResult) {
            case (.success(let company), .success(let url)):
                self.company = company
                self.logoURL = url
            default: print("something went wrong...")
            }
        }.store(in: &cancellables)
    }
}
