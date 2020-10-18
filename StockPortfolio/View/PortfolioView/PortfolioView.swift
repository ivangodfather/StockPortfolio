//
//  PortfolioView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 06/10/2020.
//

import SwiftUI

struct PortfolioView: View {

    @StateObject private var viewModel = PortfolioViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.hasNoStocks {
                    Button("Insert sample data") {
                        viewModel.insertSampleData()
                    }.font(.headline)
                } else {
                    QuoteListView(quotes: viewModel.quotes) { indexSet in
                        self.viewModel.deleteQuote(at: indexSet)
                    }
                }
            }
            .navigationTitle("Stock Portfolio")
            .navigationBarItems(leading: EditButton())
        }
        .onAppear {
            viewModel.loadQuotes()
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
