//
//  WatchlistsView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 06/10/2020.
//

import SwiftUI

struct WatchlistsView: View {

    @StateObject private var viewModel = WatchlistsViewModel()
    @State var selectedWatchList = 0
    @State private var wachtlistsIsPresented = false

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.quotes.isEmpty {
                    Button("Insert sample data") {
                        viewModel.insertSampleData()
                    }.font(.headline)
                } else {

                    QuoteListView(quotes: viewModel.quotes) { indexSet in
                        self.viewModel.deleteQuote(at: indexSet)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button(action: {
                            wachtlistsIsPresented.toggle()
                    }, label: {
                        HStack {
                            Text(viewModel.selectedWatchlist?.name ?? "Watchlists")
                            Image(systemName: "arrow.turn.right.down")
                        }
                    })
                }
            }
            .navigationBarItems(leading: EditButton())
        }
        .onAppear {
            viewModel.loadWatchlists()
        }
        .onChange(of: selectedWatchList, perform: { index in
            self.viewModel.selectedWatchlist = self.viewModel.watchLists[index]
        })
        .sheet(isPresented: $wachtlistsIsPresented) {
            ManageWatchlists() { watchlist in
                DispatchQueue.main.async {
                    self.viewModel.selectedWatchlist = watchlist
                    self.wachtlistsIsPresented = false
                }

            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistsView()
    }
}
