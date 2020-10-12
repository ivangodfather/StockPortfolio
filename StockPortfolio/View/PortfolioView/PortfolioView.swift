//
//  PortfolioView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 06/10/2020.
//

import SwiftUI

struct PortfolioView: View {

    @StateObject private var viewModel = PortfolioViewModel()
    @State private var showingAddStockView = false

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.hasNoStocks {
                    Button("Insert sample data") {
                        viewModel.insertSampleData()
                    }.font(.headline)
                } else {
                    PortfolioValueView(portfolioValue: viewModel.portfolioValue)
                    QuoteListView(stockQuotes: viewModel.stockQuotes) { indexSet in
                        self.viewModel.deleteQuote(at: indexSet)
                    }
                }
            }
            .sheet(isPresented: $showingAddStockView, content: {
                AddStockView { _ in
                    viewModel.loadQuotes()
                }
            })
            .navigationTitle("Stock Portfolio")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddStockView = true
            }) { Image(systemName: "plus").imageScale(.large) })
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
