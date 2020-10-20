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
            ("Dividend Yield" , stats.dividendYield?.round2() ?? "N/A"),
            ("Market Cap" , stats.marketcap.formattedWithSeparator),
            ("Shares Outstanding" , stats.sharesOutstanding.formattedWithSeparator),
            ("P/E Ratio" , stats.peRatio.description),
            ("Ex-Dividend Day" , stats.exDividendDate ?? "N/A"),
            ("Next Earnings Date", stats.nextEarningsDate)
        ]
    }

    var body: some View {
        GroupBox(label: Title("Key Stats")) {
            ForEach(Array(tuples.enumerated()), id: \.0) { index, tuple in
                HStack {
                    Text(tuple.key)
                        .font(.callout)
                    Spacer()
                    Text(tuple.value)
                        .font(.callout)
                        .bold()
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(index % 2 == 0 ? Color.gray.opacity(0.5) : Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))

            }
        }.groupBoxStyle(MyGroupBoxStyle())
    }
}

struct KeyDataView_Previews: PreviewProvider {
    static var previews: some View {
        KeyDataView(stats: .random)
    }
}
