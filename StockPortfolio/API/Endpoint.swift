//
//  Endpoint.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import Combine
import Foundation

struct Endpoint<Item: Decodable> {
    let provider: EndpointProvider
    let path: String
    let queryItems: [URLQueryItem]

    var urlRequest: URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = provider.host
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("invalid URL")
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        request.allHTTPHeaderFields = provider.headers
        return request
    }
}

extension Endpoint {
    static func get(symbols: [String]) -> Endpoint<[String: IEXQuote]> {
        Endpoint<[String: IEXQuote]>(provider: EndpointProvider.iexCloud, path: "/stable/stock/market/batch",
        queryItems: [
            URLQueryItem(name: "symbols", value: symbols.joined(separator: ",")),
            URLQueryItem(name: "types", value: "quote"),
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func chart(from symbol: String, period: String) -> Endpoint<[IEXChart]> {
        Endpoint<[IEXChart]>(provider: EndpointProvider.iexCloud, path: "/stable/stock/\(symbol)/chart/\(period)", queryItems: [
            URLQueryItem(name: "chartCloseOnly", value: "true"),
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func news(from symbol: String, items: Int) -> Endpoint<[IEXNews]> {
        Endpoint<[IEXNews]>(provider: EndpointProvider.iexCloud, path: "/stable/stock/\(symbol)/news/last/\(items)", queryItems: [
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func autocomplete(from text: String) -> Endpoint<RapidAPIAutocompleteResponse> {
        Endpoint<RapidAPIAutocompleteResponse>(provider: EndpointProvider.rapidAPI, path: "/auto-complete", queryItems: [
            URLQueryItem(name: "region", value: "US"),
            URLQueryItem(name: "q", value: text)
        ])
    }

    static func company(from symbol: String) -> Endpoint<IEXCompany> {
        Endpoint<IEXCompany>(provider: EndpointProvider.iexCloud, path: "/stable/stock/\(symbol)/company", queryItems: [
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func marketInfo(listType: String) -> Endpoint<[IEXQuote.Quote]> {
        Endpoint<[IEXQuote.Quote]>(provider: EndpointProvider.iexCloud, path: "/stable/stock/market/list/\(listType)", queryItems: [
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func logo(from symbol: String) -> Endpoint<IEXLogo> {
        Endpoint<IEXLogo>(provider: EndpointProvider.iexCloud, path: "/stable/stock/\(symbol)/logo", queryItems: [
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }
}
