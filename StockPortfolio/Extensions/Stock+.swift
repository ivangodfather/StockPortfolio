//
//  Stock+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation

extension Quote {

    static let random = Quote(symbol: "AAPL",
                                    companyName: "Apple Inc.",
                                    latestPrice: 100,
                                    previousClose: 90)
    
    static let company = Company(symbol: "AAPL", exchange: "NASDAQ", industry: "Agriculture", website: URL(string: "http://www.apple.com")!, ceo: "Tim Cook", description: "Apple Inc. is an American multinational technology company headquartered in Cupertino, California, that designs, develops, and sells consumer electronics, computer software, and online services. It is considered one of the Big Tech technology companies, alongside Amazon, Google, Microsoft, and Facebook.", securityName: "Apple", issueType: .cs, sector: "Random", employees: 32000, tags: ["iphone, ipad, mac"], country: "US")
}
