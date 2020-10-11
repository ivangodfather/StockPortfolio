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
    let date: Date
    let url: URL
    let summary: String
    let imageURL: URL
    let related: String
    var id: String { headline }

    var dateString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
       return formatter.localizedString(for: date, relativeTo: Date())
    }

    var isFeatured: Bool {
        headline.contains("i") && headline.contains("w")
    }
}

extension News {
    init(news: IEXNews) {
        headline = news.headline
        source = news.source
        url = news.url
        summary = news.summary
        imageURL = news.image
        related = news.related
        date = Date(timeIntervalSince1970: news.datetime / 1000)
        print("source \(news.source) \(news.headline) \(news.image)")
    }
}
