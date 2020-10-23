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
        VStack {
            HStack {
                Text("Symbol")
                    .padding(.leading, 24)
                Spacer()
                Text("Price").padding(.trailing, 4)
                Text("% Change").padding(.trailing, 44)
            }
            .foregroundColor(.primary)
            .font(Font.caption.weight(.semibold))
            .padding(.vertical, 8)
            .background(Color.App.background)
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
}

struct QuoteListView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteListView(quotes: [.random, .random, .random], onDelete: nil)
    }
}
