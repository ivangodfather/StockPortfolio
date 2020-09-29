//
//  StockDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI

struct StockDetail: View {

    var stock: Stock

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(stock.news) { news in
                    Text(news.headline).font(.headline)
                    HStack {
                        Text("Source: " + news.source).bold()
                        Link("Go to website", destination: news.url)
                    }.font(.callout)
                    Text(news.summary)
                    Divider()
                        .padding(.vertical, 16)
                }
            }
            .padding()
            .navigationTitle(stock.companyName)
        }
    }
}

struct StockDetail_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail(stock: Stock(symbol: "AAPL", companyName: "Apple Inc.", latestPrice: 100, previousClose: 90, logo: URL(string: "https://www.apple.com/euro/retail/home/d/generic/images/og.jpg?202008110017")!, news: [Stock.News(headline: "Headline!", source: "Any Source", url: URL(string: "https://www.google.com/")!, summary: "Any summary")]))
    }
}
