//
//  Company.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 05/10/2020.
//

import Foundation

struct Company {
    let symbol: String
    let exchange: String
    let industry: String
    let website: URL
    let ceo: String
    let description: String
    let securityName: String
    let issueType: IssueType
    let sector: String
    let employees: Int?
    let tags: [String]
    let country: String

    enum IssueType: String, Decodable {
        case cs = "cs" // Common Stock
        case et = "et" // Exchange Traded Fund (ETF)
        case wt = "wt" // Warrant
        case rt = "rt" // Right
        case re = "re" // Real Estate Investment Trust (REIT’s)
        case ad = "ad" // American Depository Receipt (ADR’s)
        case sc = "sc"
    }
}

extension Company {
    init(iexCompany: IEXCompany) {
        symbol = iexCompany.symbol
        exchange = iexCompany.exchange
        industry = iexCompany.industry
        website = iexCompany.website
        description = iexCompany.description
        securityName = iexCompany.securityName
        issueType = IssueType(rawValue: iexCompany.issueType) ?? .cs
        sector = iexCompany.sector
        employees = iexCompany.employees
        tags = iexCompany.tags
        country = iexCompany.country
        ceo = iexCompany.CEO
    }

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
