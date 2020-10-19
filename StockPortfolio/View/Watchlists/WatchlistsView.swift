//
//  WatchlistsView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 18/10/2020.
//

import SwiftUI

struct WatchlistsView: View {

    var symbol: String
    @Binding var isPresented: Bool
    @StateObject private var viewModel = WatchlistsViewModel()
    @State var createNewWatchlistIsPresented = false

    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading: EmptyView()
                case .error: EmptyView()
                case .loaded(let watchlists):
                    List {
                        ForEach(watchlists) { watchlist in
                            Button(action: {
                                self.viewModel.save(symbol: symbol, for: watchlist)
                                self.isPresented = false
                            }) {  Text(watchlist.name) }
                        }.onDelete(perform: self.viewModel.delete)
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("Your Watchlists")
                    Spacer()
                    Button(action: { createNewWatchlistIsPresented.toggle() }, label: {
                        Text("Create a new watchlist")
                    })
                }
            }
            .sheet(isPresented: $createNewWatchlistIsPresented, content: {
                NewWatchlistView(completion: { self.viewModel.requestWatchlists() } )
            })
            .navigationBarItems(leading: EditButton())
            .onReceive(viewModel.$finishedSavingSymbol) { isPresented = !$0 }
            .onAppear(perform: self.viewModel.requestWatchlists)
        }
    }


}

struct WatchlistsView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistsView(symbol: "AAPL", isPresented: .constant(true))
    }
}
