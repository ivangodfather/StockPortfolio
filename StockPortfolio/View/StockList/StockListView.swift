//
//  ContentView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import SwiftUI
import Combine
import CoreData

struct StockListView: View {

    @StateObject private var viewModel = StockListViewModel()
    @State private var showingAddStockView = false

    var body: some View {
        NavigationView {
            VStack {
                PortfolioValueView(portfolioValue: viewModel.portfolioValue)
                List {
                    ForEach(viewModel.stocks, id: \.symbol) { stock in
                        NavigationLink(
                            destination: StockDetail(stock: stock)) {
                            StockRowView(stock: stock)
                        }
                    }
                    .onDelete(perform: viewModel.deleteStock(at:))
                }
            }.listStyle(PlainListStyle())
            .sheet(isPresented: $showingAddStockView, content: {
                AddStockView(show: self.$showingAddStockView) { symbol, shares in
                    self.viewModel.addStock(symbol: symbol, shares: shares)
                }
            })
            .navigationTitle("Stock Portfolio")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddStockView = true
            }) { Image(systemName: "plus").imageScale(.large) })
        }
        .onAppear {
            viewModel.loadStocks()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StockListView()
    }
}
