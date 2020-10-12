//
//  Stock+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation

extension Quote {

    static let random = Quote(symbol: "AMD",
                                    companyName: "Advanced Micro Devices Inc.",
                                    latestPrice: 100,
                                    previousClose: 90,
                                    changePercent: "-1.19",
                                    logo: URL(string: "https://www.experimenta.es/wp-content/uploads/2018/10/tesla-logo.jpg")!)
    
    static let company = Company(symbol: "AAPL",
                                 exchange: "NASDAQ",
                                 industry: "Agriculture",
                                 website: URL(string: "http://www.apple.com")!,
                                 ceo: "Tim Cook",
                                 description: "Apple Inc. is an American multinational ...",
                                 securityName: "Apple",
                                 issueType: .cs,
                                 sector: "Random",
                                 employees: 32000,
                                 tags: ["iphone, ipad, mac"],
                                 country: "US")
}
