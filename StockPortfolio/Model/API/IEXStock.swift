//
//  IEXResponse.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation

struct IEXStock: Decodable {
    let quote: Quote
    let logo: Logo
    let company: Company

    struct Quote: Decodable {
        let symbol: String
        let companyName: String
        let latestPrice: Double?
        let previousClose: Double?
    }

    struct Logo: Decodable {
        let url: URL
    }

    struct Company: Decodable {
        let exchange: String
        let industry: String
        let website: URL
        let CEO: String
        let description: String
        let securityName: String
        let issueType: StockDetail.IssueType
        let sector: String
        let employees: Int
        let tags: [String]
        let country: String
    }
}

extension StockDetail {
    init(iexStock: IEXStock, shares: Int) {
        symbol = iexStock.quote.symbol
        self.shares = shares
        companyName = iexStock.quote.companyName
        latestPrice = iexStock.quote.latestPrice ?? 0
        previousClose = iexStock.quote.previousClose ?? 0
        logo = iexStock.logo.url
        company = StockDetail.Company(company: iexStock.company)
    }
}

extension StockDetail.Company {
    init(company: IEXStock.Company) {
        exchange = company.exchange
        industry = company.industry
        website = company.website
        description = company.description
        securityName = company.securityName
        issueType = company.issueType
        sector = company.sector
        employees = company.employees
        tags = company.tags
        country = company.country
        ceo = company.CEO
    }
}
