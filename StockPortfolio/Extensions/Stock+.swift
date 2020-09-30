//
//  Stock+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation

extension Stock {
    static let randomStock = Stock(symbol: "AAPL",
                                   companyName: "Apple Inc.",
                                   latestPrice: 100,
                                   previousClose: 90,
                                   logo: URL(string: "https://www.apple.com/euro/retail/home/d/generic/images/og.jpg?202008110017")!,
                                   news: [Stock.News(headline: "Headline!", source: "Any Source", url: URL(string: "https://www.google.com/")!, summary: "Any summary")])
}
