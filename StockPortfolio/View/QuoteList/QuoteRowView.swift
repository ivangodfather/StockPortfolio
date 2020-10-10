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
                HStack(spacing: 5) {
                    Text(stockQuote.quote.companyName).bold().font(.callout)
                    Text("(\(stockQuote.quote.symbol))").font(.footnote)
                }
                HStack {
                    Text("\(stockQuote.numberOfShares) shares * \(stockQuote.quote.latestPrice.round2())")
                }.font(.footnote)
            }.layoutPriority(-1)
            Spacer()
            VStack(alignment: .trailing) {
                HStack(spacing: 0) {
                    Text("$")
                    Text(stockQuote.currentValueString)
                }.font(.headline)
                HStack(spacing: 4) {
                    Text("\(stockQuote.quote.changePercent)%")
                    Text("(\(stockQuote.quote.gainLossString))")
                }
                .foregroundColor(stockQuote.quote.percentage > 0 ? Color.Stock.green : Color.Stock.red)
                .font(Font.system(size: 9))
            }
        }
        .padding(.vertical)
    }
}

struct QuoteRowView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteRowView(stockQuote: StockQuote.random).previewLayout(PreviewLayout.fixed(width: 500, height: 100))
    }
}
