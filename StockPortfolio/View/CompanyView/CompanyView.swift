//
//  CompanyDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import Combine

struct CompanyView: View {

    let symbol: String
    @StateObject private var viewModel = CompanyViewModel()

    var body: some View {
        VStack {
            if let logoURL = viewModel.logoURL, let company = viewModel.company {
                CompanyBodyView(company: company, logoURL: logoURL)
                    .navigationTitle(symbol)
                    .navigationBarItems(trailing: NavigationLink("Chart", destination: ChartView(symbol: symbol)))
            } else {
                ProgressView()
            }
        }
        .onAppear {
            self.viewModel.requestCompanyData(from: symbol)
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView(symbol: "AAPL")
    }
}
