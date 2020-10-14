//
//  CompanyDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import Foundation

struct CompanyDetail {
    let company: Company
    let news: [News]
    let stats: Stats
    let logo: URL
}

extension CompanyDetail {
    init(companyDetail: IEXCompanyDetail) {
        company = Company(iexCompany: companyDetail.company)
        stats = Stats(stats: companyDetail.stats)
        news = companyDetail.news.map(News.init(news:))
        logo = companyDetail.logo.url
    }

    static let random = CompanyDetail(company: .random,
                                      news: [.random, .random, .random],
                                      stats: .random,
                                      logo: .random)
}
