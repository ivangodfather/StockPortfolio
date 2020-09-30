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

extension Stock {
    init(iexStock: IEXStock) {
        symbol = iexStock.quote.symbol
        companyName = iexStock.quote.companyName
        latestPrice = iexStock.quote.latestPrice
        previousClose = iexStock.quote.previousClose
        logo = iexStock.logo.url
        news = iexStock.news.map(Stock.News.init(news:))
    }
}

extension Stock.News {
    init(news: IEXStock.News) {
        headline = news.headline
        source = news.source
        url = news.url
        summary = news.summary
    }
}
