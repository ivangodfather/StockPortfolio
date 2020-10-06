//
//  ContentView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import SwiftUI
import Combine
import CoreData

struct QuoteListView: View {
    let quotes: [Quote]
    let onDelete: ((IndexSet) -> Void)?
    
    var body: some View {
        List {
            ForEach(quotes, id: \.symbol) { quote in
                NavigationLink(
                    destination: StockDetailView(symbol: quote.symbol)) {
                    QuoteRowView(quote: quote)
                }
            }.onDelete(perform: onDelete)
        }
        .listStyle(PlainListStyle())
    }
}


struct QuoteListView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteListView(quotes: [Quote.random, Quote.random], onDelete: nil)
    }
}
