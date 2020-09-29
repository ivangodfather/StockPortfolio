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
            URLQueryItem(name: "types", value: "quote,news,chart,logo"),
            URLQueryItem(name: "range", value: "1m"),
            URLQueryItem(name: "last", value: "10"),
            URLQueryItem(name: "token", value: Environment.sandboxKey)
        ])
    }
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Environment.sandboxURL
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("invalid URL")
        }
        return url
    }
}
