//
//  EndpointProvider.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 05/10/2020.
//

import Foundation

struct EndpointProvider {
    let host: String
    let headers: [String: String]
}

extension EndpointProvider {
    static let iexCloud = EndpointProvider(host: EnvironmentValue.iexHost, headers: [String: String]())
    static let rapidAPI = EndpointProvider(host: EnvironmentValue.rapidAPIHost,
                                           headers: ["x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com",
                                                     "x-rapidapi-key": "9fc0db1d7cmshaae343f3cbf1bc5p17ddfbjsne136a12b5570"])
}
