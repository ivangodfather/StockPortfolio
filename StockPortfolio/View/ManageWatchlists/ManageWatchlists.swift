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
                case .loading: EmptyView()
                case .error: EmptyView()
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
                                Text(watchlist.name)
                            }
                        }
                        .onDelete(perform: self.viewModel.delete)
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
