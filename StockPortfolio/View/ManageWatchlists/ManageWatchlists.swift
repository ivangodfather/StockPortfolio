//
//  ManageWatchlists.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 18/10/2020.
//

import SwiftUI

struct ManageWatchlists: View {

    var symbol: String? = nil
    let didSelectWatchlist: ((Watchlist) -> ())?
    let didDeleteWatchlist: ((Watchlist) -> Void)?

    init(symbol: String? = nil,
         didSelectWatchlist: ((Watchlist) -> ())? = nil,
         didDeleteWatchlist: ((Watchlist) -> Void)? = nil) {
        self.symbol = symbol
        self.didSelectWatchlist = didSelectWatchlist
        self.didDeleteWatchlist = didDeleteWatchlist
    }

    @StateObject private var viewModel = ManageWatchlistsViewModel()
    @State var createNewWatchlistIsPresented = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading: ProgressView()
                case .error: EmptyView()
                case .empty: NoDataView(title: "Still no watchlist!", subtitle: "Create a watchlist and start adding your favorites symbols", button: ("Create new watchlist", { createNewWatchlistIsPresented.toggle() } ))
                case .loaded(let watchlists):
                    List {
                        ForEach(watchlists) { watchlist in
                            Button(action: {
                                if let symbol = symbol {
                                    self.viewModel.save(symbol: symbol, for: watchlist)
                                } else {
                                    didSelectWatchlist?(watchlist)
                                }
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text(watchlist.name).font(.headline).foregroundColor(Color.Stock.blue)
                            }
                        }
                        .onDelete(perform: self.viewModel.delete)
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("Your Watchlists")
                    Spacer()
                    ActionButton(action: { createNewWatchlistIsPresented.toggle() }, image: Image(systemName: "plus"), text: "Create new watchlist")
                        .padding(.vertical, 24)
                }
            }
            .sheet(isPresented: $createNewWatchlistIsPresented, content: {
                NewWatchlistView(completion: { self.viewModel.requestWatchlists() } )
            })
            .navigationBarItems(leading: EditButton().foregroundColor(Color.Stock.blue))
            .onReceive(viewModel.$didDeleteWatchList) { watchlist in
                if let watchlist = watchlist {
                    didDeleteWatchlist?(watchlist)
                }
            }
            .onAppear(perform: self.viewModel.requestWatchlists)
        }
    }


}

struct ManageWatchlists_Previews: PreviewProvider {
    static var previews: some View {
        ManageWatchlists(symbol: "AAPL")
    }
}
