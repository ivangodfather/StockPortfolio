//
//  IEXCompanyDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import Foundation

struct IEXCompanyDetail: Decodable {
    let company: IEXCompany
    let news: [IEXNews]
    let stats: IEXStats
    let logo: IEXLogo
    let quote: IEXQuote
    let recommendationTrends: [IEXRecommendationTrend]
    let priceTarget: IEXPriceTarget


    private enum CodingKeys : String, CodingKey {
        case company, news, stats, logo, quote, recommendationTrends = "recommendation-trends", priceTarget = "price-target"
    }
}
