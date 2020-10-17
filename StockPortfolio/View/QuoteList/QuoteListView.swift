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
    let quotes: [QuoteDetail]
    let onDelete: ((IndexSet) -> Void)?
    
    var body: some View {
        List {
            ForEach(quotes) { quote in
                NavigationLink(
                    destination: CompanyView(symbol: quote.quote.symbol)) {
                    QuoteRowView(quoteDetail: quote)
                }
            }.onDelete(perform: onDelete)
        }
        .listStyle(PlainListStyle())
    }
}

struct QuoteListView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteListView(quotes: [QuoteDetail.random, QuoteDetail.random], onDelete: nil)
    }
}
