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
    let stockQuotes: [StockQuote]
    let onDelete: ((IndexSet) -> Void)?
    
    var body: some View {
        List {
            ForEach(stockQuotes) { stockQuote in
                NavigationLink(
                    destination: CompanyView(symbol: stockQuote.quote.symbol)) {
                    QuoteRowView(stockQuote: stockQuote)
                }
            }.onDelete(perform: onDelete)
        }
        .listStyle(PlainListStyle())
    }
}

struct QuoteListView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteListView(stockQuotes: [StockQuote.random, StockQuote.random], onDelete: nil)
    }
}
