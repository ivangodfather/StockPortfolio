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
            ("P/E Ratio" , stats.peRatio?.description ?? "N/A"),
            ("Ex-Dividend Day" , stats.exDividendDate ?? "N/A"),
            ("Next Earnings Date", stats.nextEarningsDate ?? "N/A")
        ]
    }

    var body: some View {
        DetailListView(title: "Key Stats", data: tuples)
    }
}

struct KeyDataView_Previews: PreviewProvider {
    static var previews: some View {
        KeyDataView(stats: .random)
    }
}
