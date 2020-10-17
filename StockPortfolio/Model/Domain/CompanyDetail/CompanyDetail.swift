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
    let quote: Quote
    let recommendationTrend: [RecommendationTrend]
    let priceTarget: PriceTarget
}

extension CompanyDetail {
    init(companyDetail: IEXCompanyDetail) {
        company = Company(iexCompany: companyDetail.company)
        stats = Stats(stats: companyDetail.stats)
        news = companyDetail.news.map(News.init)
        logo = companyDetail.logo.url
        quote = Quote(quote: companyDetail.quote)
        recommendationTrend = companyDetail.recommendationTrends.map(RecommendationTrend.init)
        priceTarget = PriceTarget(priceTarget: companyDetail.priceTarget)
    }

    static let random = CompanyDetail(company: .random,
                                      news: [.random, .random, .random],
                                      stats: .random,
                                      logo: .random,
                                      quote: .random,
                                      recommendationTrend: [.random],
                                      priceTarget: .random)
}
