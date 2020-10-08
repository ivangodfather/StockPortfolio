//
//  StockView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import Foundation

struct QuoteRowView: View {
    var stockQuote: StockQuote

    var body: some View {
        HStack {
            ZStack {
                Circle().fill(Color.gray)
                AsyncImage(url: stockQuote.quote.logo) {
                    ProgressView()
                }.frame(width: 48, height: 48)
            }.frame(width: 48, height: 48, alignment: .center)
            VStack(alignment: .leading, spacing: 4) {
                Text(stockQuote.quote.companyName).bold()
                Text(stockQuote.quote.symbol).font(.caption)
            }.padding(0)
            Spacer()
            VStack(alignment: .trailing) {
                HStack(spacing: 0) {
                    Text("$")
                    Text(stockQuote.quote.latestPrice.description)
                }.font(.headline)
                Text("\(stockQuote.quote.changePercent)%")
                    .foregroundColor(stockQuote.quote.percentage > 0 ? Color.Stock.green : Color.Stock.red)
                    .font(.body)
            }.padding(.horizontal)
        }
        .padding(.vertical)
    }
}

struct QuoteRowView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteRowView(stockQuote: StockQuote.random)
    }
}
