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
    let useExtendedHours: Bool
    let onDelete: ((IndexSet) -> Void)?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(quotes) { quote in
                    NavigationLink(
                        destination: CompanyView(symbol: quote.quote.symbol)) {
                        QuoteRowView(quoteDetail: quote, useExtendedHours: useExtendedHours)
                    }
                }.onDelete(perform: onDelete)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct QuoteListView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteListView(quotes: [.random, .random, .random], useExtendedHours: false, onDelete: nil)
    }
}
