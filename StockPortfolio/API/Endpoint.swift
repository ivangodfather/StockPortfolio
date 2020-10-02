//
//  Endpoint.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import Combine
import Foundation

struct Endpoint<Item: Decodable> {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func get(symbols: [String]) -> Endpoint<[String: IEXStock]> {
        Endpoint<[String: IEXStock]>(path: "/stable/stock/market/batch",
        queryItems: [
            URLQueryItem(name: "symbols", value: symbols.joined(separator: ",")),
            URLQueryItem(name: "types", value: "quote,logo,company"),
            URLQueryItem(name: "range", value: "1m"),
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func chart(from symbol: String, period: String) -> Endpoint<[IEXChart]> {
        Endpoint<[IEXChart]>(path: "/stable/stock/\(symbol)/chart/\(period)", queryItems: [
            URLQueryItem(name: "chartCloseOnly", value: "true"),
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func news(from symbol: String, items: Int) -> Endpoint<[News]> {
        Endpoint<[News]>(path: "/stable/stock/\(symbol)/news/last/\(items)", queryItems: [
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])

    }
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = EnvironmentValue.iexHost
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("invalid URL")
        }
        return url
    }
}
