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
            RemoteImage(url: stockQuote.quoteDetail.logo)
                .frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: 4) {
                Text("\(stockQuote.quoteDetail.quote.companyName) (\(stockQuote.quoteDetail.quote.symbol))").bold().font(.callout)
                HStack {
                    if stockQuote.numberOfShares > 0 {
                        Text("\(stockQuote.numberOfShares) shares * ")
                    }
                    Text(stockQuote.quoteDetail.quote.latestPrice.round2())
                }.font(.footnote)
            }.layoutPriority(-1)
            Spacer()
            VStack(alignment: .trailing) {
                if stockQuote.numberOfShares > 0 {
                    HStack(spacing: 0) {
                        Text("$")
                        Text(stockQuote.currentValueString)
                    }.font(.headline)
                    .foregroundColor(Color.Stock.gray)
                    HStack(spacing: 4) {
                        Text("\(stockQuote.quoteDetail.quote.changePercent)%")
                        Text("(\(stockQuote.totalGainLoss))")
                    }
                    .font(.system(size: 9))
                } else {
                    Text("\(stockQuote.quoteDetail.quote.changePercent)%")
                        .font(.callout).bold()
                }
            }.foregroundColor(stockQuote.quoteDetail.quote.percentage >= 0 ? Color.Stock.green : Color.Stock.red)

        }
        .padding(.vertical)
    }
}

struct QuoteRowView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteRowView(stockQuote: StockQuote.random).previewLayout(PreviewLayout.fixed(width: 300, height: 100))
    }
}
