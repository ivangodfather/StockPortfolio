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
    @State private var watchListIsPresented = false

    var body: some View {
        VStack {
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
        .navigationBarItems(trailing: HStack {
            Button(action: { watchListIsPresented.toggle() }, label: {
                Image(systemName: "plus")
            })
        })
        .onAppear {
            self.viewModel.requestCompanyData(from: symbol)
        }
        .sheet(isPresented: $watchListIsPresented) {
            ManageWatchlists(symbol: symbol)
        }
    }
}
