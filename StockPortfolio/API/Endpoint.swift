//
//  Endpoint.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import Combine
import Foundation

struct Endpoint<Item: Decodable> {
    let host: String
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func get(symbols: [String]) -> Endpoint<[String: IEXStock]> {
        Endpoint<[String: IEXStock]>(host: EnvironmentValue.iexHost, path: "/stable/stock/market/batch",
        queryItems: [
            URLQueryItem(name: "symbols", value: symbols.joined(separator: ",")),
            URLQueryItem(name: "types", value: "quote,logo,company"),
            URLQueryItem(name: "range", value: "1m"),
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func chart(from symbol: String, period: String) -> Endpoint<[IEXChart]> {
        Endpoint<[IEXChart]>(host: EnvironmentValue.iexHost, path: "/stable/stock/\(symbol)/chart/\(period)", queryItems: [
            URLQueryItem(name: "chartCloseOnly", value: "true"),
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func news(from symbol: String, items: Int) -> Endpoint<[News]> {
        Endpoint<[News]>(host: EnvironmentValue.iexHost, path: "/stable/stock/\(symbol)/news/last/\(items)", queryItems: [
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func autocomplete(from text: String) -> Endpoint<RapidAPIAutocompleteResponse> {
        Endpoint<RapidAPIAutocompleteResponse>(host: EnvironmentValue.rapidAPIHost, path: "/auto-complete", queryItems: [
            URLQueryItem(name: "region", value: "US"),
            URLQueryItem(name: "q", value: text)
        ])
    }
}

extension Endpoint {
    var urlRequest: URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("invalid URL")
        }
        var request = URLRequest(url: url)
        if host == EnvironmentValue.rapidAPIHost {
            request.addValue("apidojo-yahoo-finance-v1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
            request.addValue("mulgiitohmeq8elnhwefk24wz0dfyw", forHTTPHeaderField: "x-rapidapi-key")
        }
        return request
    }
}
