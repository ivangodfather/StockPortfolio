//
//  ManageWatchlists.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 18/10/2020.
//

import SwiftUI

struct ManageWatchlists: View {

    var symbol: String? = nil
    let completion: (Watchlist) -> ()
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
                                    completion(watchlist)
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
                    ActionButton(action: { createNewWatchlistIsPresented.toggle() }, image: Image(systemName: "plus"), text: "Create new watchlist").padding(.vertical, 24)
                }
            }
            .sheet(isPresented: $createNewWatchlistIsPresented, content: {
                NewWatchlistView(completion: { self.viewModel.requestWatchlists() } )
            })
            .navigationBarItems(leading: EditButton().foregroundColor(Color.Stock.blue))
            .onReceive(viewModel.$finishedSavingSymbol) { saved in

            }
            .onAppear(perform: self.viewModel.requestWatchlists)
        }
    }


}

struct ManageWatchlists_Previews: PreviewProvider {
    static var previews: some View {
        ManageWatchlists(symbol: "AAPL", completion: { _ in })
    }
}
