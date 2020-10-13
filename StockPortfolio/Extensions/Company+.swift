//
//  Company+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 13/10/2020.
//

import Foundation

extension Company {
    static let random = Company(symbol: "AAPL",
                                exchange: "NASDAQ",
                                industry: "Some Industry",
                                website: .random,
                                ceo: "Tim Cook",
                                description: "Some random description",
                                securityName: "Apple Inc.",
                                issueType: .cs,
                                sector: "IT",
                                employees: 150,
                                tags: ["IT", "Medical Care"],
                                country: "US")
}
