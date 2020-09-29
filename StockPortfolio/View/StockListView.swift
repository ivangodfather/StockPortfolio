//
//  ContentView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import SwiftUI
import Combine

struct ContentView: View {

    @StateObject private var viewModel = StockListViewModel()
    @State private var showingAddStockView = false

    var body: some View {
        NavigationView {
            List(viewModel.stocks, id: \.symbol) { stock in
                HStack {
                    ZStack {
                        Circle()
                            .fill(Color.red)
                        Image(systemName: "power")
                        AsyncImage(url: stock.logo) {
                            Text("Loading")
                        }.frame(width: 48, height: 48)
                    }.frame(width: 48, height: 48, alignment: .center)
                    VStack {
                        Text(stock.companyName)
                        Text(stock.symbol)
                    }
                    Spacer()
                    VStack {
                        HStack(spacing: 0) {
                            Text(stock.latestPrice.description)
                            Text("$")
                        }
                        Text("13%").foregroundColor(.red)
                    }
                }
            }
            .padding()
            .sheet(isPresented: $showingAddStockView, content: {
                AddStockView(show: self.$showingAddStockView) { symbol, shares in
                    self.viewModel.addStock(symbol: symbol)
                }
            })
            .navigationTitle("Stock Portfolio")
            .navigationBarItems(trailing: Button(action: {
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
        ContentView()
    }
}
