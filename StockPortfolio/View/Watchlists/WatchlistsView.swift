//
//  WatchlistsView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 18/10/2020.
//

import SwiftUI

struct WatchlistsView: View {
    var body: some View {
        NavigationView {
            List {
                
            }
        }
        .navigationTitle("Your Watchlists")
        .navigationBarItems(leading: Button(action: {}, label: {
            Text("Close")
        }), trailing: EditButton())
    }
}

struct WatchlistsView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistsView()
    }
}
