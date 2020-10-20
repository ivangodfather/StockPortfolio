//
//  NewWatchlistView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 18/10/2020.
//

import SwiftUI

struct NewWatchlistView: View {

    var completion: () -> ()
    @State private var name = ""
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = NewWatchlistViewModel()

    var body: some View {
        NavigationView {
            Form {
                TextField("Enter your watchlist name", text: $name, onCommit:  {
                    self.viewModel.saveWatchlist(name: name)
                }).foregroundColor(Color.primary)
            }
            .navigationTitle("New Watchlist")
            .onReceive(viewModel.$watchlistCreated, perform: { created in
                if created {
                    completion()
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct NewWatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        NewWatchlistView(completion: {})
    }
}
