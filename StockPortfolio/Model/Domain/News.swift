//
//  News.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 02/10/2020.
//

import Foundation

struct News: Decodable, Identifiable {
    let headline: String
    let source: String
    let url: URL
    let summary: String
    let image: String
    var id: String { headline }
}

extension News {
    init(news: IEXNews) {
        headline = news.headline
        source = news.source
        url = news.url
        summary = news.summary
        image = news.image
    }
}
