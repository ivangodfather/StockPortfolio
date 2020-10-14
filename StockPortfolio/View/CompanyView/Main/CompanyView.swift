//
//  CompanyContainerView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 13/10/2020.
//

import SwiftUI

struct CompanyView: View {

    let symbol: String

    @StateObject private var viewModel = CompanyViewModel()

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .error(let errorDescription):
                Text(errorDescription)
            case .loaded(let companyDetail):
                CompanyLoadedStateView(companyDetail: companyDetail)
            }
        }
        .navigationBarTitle(symbol, displayMode: .inline)
        .onAppear {
            self.viewModel.requestCompanyData(from: symbol)
        }
    }
}
