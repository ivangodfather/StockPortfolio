//
//  PortfolioView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 06/10/2020.
//

import SwiftUI

struct PortfolioView: View {

    @StateObject private var viewModel = PortfolioViewModel()
    @State var selectedWatchList = 0

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.quotes.isEmpty {
                    Button("Insert sample data") {
                        viewModel.insertSampleData()
                    }.font(.headline)
                } else {
                    Picker(selection: $selectedWatchList, label: Text("Select a watchlist")) {
                        ForEach(0 ..< viewModel.watchLists.count) {
                            Text(viewModel.watchLists[$0].name)
                       }
                    }
                    QuoteListView(quotes: viewModel.quotes) { indexSet in
                        self.viewModel.deleteQuote(at: indexSet)
                    }
                }
            }
            .navigationTitle("Stock Portfolio")
            .navigationBarItems(leading: EditButton())
        }
        .onAppear {
            viewModel.loadWatchlists()
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
