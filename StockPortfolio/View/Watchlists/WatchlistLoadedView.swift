//
//  WatchlistLoadedView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 21/10/2020.
//

import SwiftUI

struct WatchlistLoadedView: View {

    let quotes: [QuoteDetail]
    let onDelete: ((IndexSet) -> Void)?

    var body: some View {
        VStack {
            QuoteListView(quotes: quotes, onDelete: onDelete)
        }
    }
}

struct WatchlistLoadedView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistLoadedView(quotes: [.random, .random, .random, .random], onDelete: nil)
    }
}
