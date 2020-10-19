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
        related.contains("TSLA")
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
    }

    private static let newsSummary = "aipe lbtthUernwm rtptHttls eto tis ue eszf  asdf"
    static let random = News(headline: "Random headline",
                             source: "Wikipedia",
                             date: Date(),
                             url: URL(string: "http://wikipedia.org")!,
                             summary: newsSummary ,
                             imageURL: .randomImage,
                             related: "AMZN")
}

extension News: Comparable {
    static func < (lhs: News, rhs: News) -> Bool {
        lhs.date < rhs.date
    }
}
