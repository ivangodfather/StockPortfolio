//
//  StockView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import Foundation

struct QuoteRowView: View {
    var quote: Quote

    var body: some View {
        HStack {
            ZStack {
                Circle().fill(Color.gray)
                AsyncImage(url: quote.logo) {
                    ProgressView()
                }.frame(width: 48, height: 48)
            }.frame(width: 48, height: 48, alignment: .center)
            VStack(alignment: .leading, spacing: 4) {
                Text(quote.companyName).bold()
                Text(quote.symbol).font(.caption)
            }.padding(0)
            Spacer()
            VStack(alignment: .trailing) {
                HStack(spacing: 0) {
                    Text("$")
                    Text(quote.latestPrice.description)
                }.font(.headline)
                // TODO
//                Text("\(stock.percentage.round2())%").foregroundColor(quote.percentage > 0 ? Color.Stock.green : Color.Stock.red)
//                    .font(.body)
            }.padding(.horizontal)
        }
        .padding(.vertical)
    }
}

struct StockRowView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteRowView(quote: Quote.random)
    }
}
