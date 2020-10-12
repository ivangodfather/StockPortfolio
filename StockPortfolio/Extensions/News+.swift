//
//  News+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 03/10/2020.
//

import Foundation

extension News {
    static let newsSummary = "aipe lbtthUernwm rtptHttls eto tis ue eszf  asdf"
    static let random = News(headline: "Random headline",
                             source: "Wikipedia",
                             date: Date(),
                             url: URL(string: "http://wikipedia.org")!,
                             summary: newsSummary ,
                             imageURL: URL(string: "https://i2.wp.com/www.spainonafork.com/wp-content/uploads/2019/04/popcornHOR-11.png?fit=750%2C750&ssl=1")!,
                             related: "AMZN")
}
