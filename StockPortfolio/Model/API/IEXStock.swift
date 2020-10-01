//
//  IEXResponse.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation

struct IEXStock: Decodable {
    let quote: Quote
    let logo: Logo
    let news: [News]

    struct Quote: Decodable {
        let symbol: String
        let companyName: String
        let latestPrice: Double
        let previousClose: Double
    }

    struct Logo: Decodable {
        let url: URL
    }

    struct News: Decodable {
        let headline: String
        let source: String
        let url: URL
        let summary: String
    }
}

extension StockDetail {
    init(iexStock: IEXStock, shares: Int) {
        symbol = iexStock.quote.symbol
        self.shares = shares
        companyName = iexStock.quote.companyName
        latestPrice = iexStock.quote.latestPrice
        previousClose = iexStock.quote.previousClose
        logo = iexStock.logo.url
        news = iexStock.news.map(StockDetail.News.init(news:))
    }
}

extension StockDetail.News {
    init(news: IEXStock.News) {
        headline = news.headline
        source = news.source
        url = news.url
        summary = news.summary
    }
}
