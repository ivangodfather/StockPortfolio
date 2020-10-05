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
    static let rapidAPI = EndpointProvider(host: EnvironmentValue.rapidAPIHost, headers: ["x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com",
                                                                                          "x-rapidapi-key" : "mulgiitohmeq8elnhwefk24wz0dfyw"])
}
