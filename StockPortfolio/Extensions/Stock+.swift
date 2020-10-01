//
//  Stock+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation

extension StockDetail {
    static let random = StockDetail(symbol: "AAPL",
                              shares: 5,
                              companyName: "Apple Inc.",
                              latestPrice: 100,
                              previousClose: 90,
                              logo: URL(string: "https://www.apple.com/euro/retail/home/d/generic/images/og.jpg?202008110017")!,
                              news: [StockDetail.News(headline: "Headline!", source: "Any Source", url: URL(string: "https://www.google.com/")!, summary: "Any summary")])
}
