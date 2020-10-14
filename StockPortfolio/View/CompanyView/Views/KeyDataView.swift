//
//  KeyDataView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import SwiftUI

struct KeyDataView: View {
    let stats: Stats

    var tuples: [(key: String, value: String)] {
        [
            ("Volume", stats.avg30Volume.description),
            ("Dividend Yield" , stats.dividendYield?.description ?? "N/A"),
            ("Market Cap" , stats.marketcap.description),
            ("Shares Outstanding" , stats.sharesOutstanding.description),
            ("P/E Ratio" , stats.peRatio.description),
            ("Ex-Dividend Day" , stats.exDividendDate ?? "N/A"),
            ("Next Earnings Date", stats.nextEarningsDate)
        ]
    }

    var body: some View {
        VStack(spacing: 0) {
            Title("Key Stats")
                .padding(.leading)
            ForEach(Array(tuples.enumerated()), id: \.0) { index, tuple in
                HStack {
                    Text(tuple.key)
                    Spacer()
                    Text(tuple.value)
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(index % 2 == 0 ? .white : Color.Stock.gray.opacity(0.2))
                
            }
        }
    }
}

struct KeyDataView_Previews: PreviewProvider {
    static var previews: some View {
        KeyDataView(stats: .random)
    }
}
