//
//  WatchlistLoadedView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 21/10/2020.
//

import SwiftUI

struct WatchlistLoadedView: View {

    @Binding var marketType: Int
    let quotes: [QuoteDetail]
    let onDelete: ((IndexSet) -> Void)?

    var body: some View {
        VStack {
            Picker(selection: $marketType, label: Text("Hola")) {
                Text("Market").tag(0)
                Text("Extended hours").tag(1)
             }.pickerStyle(SegmentedPickerStyle())
            .padding()
            QuoteListView(quotes: quotes, useExtendedHours: marketType == 1, onDelete: onDelete)
        }
    }
}

struct WatchlistLoadedView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistLoadedView(marketType: .constant(0), quotes: [.random, .random, .random, .random], onDelete: nil)
    }
}
