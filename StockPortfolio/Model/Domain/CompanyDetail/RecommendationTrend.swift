//
//  RecommendationTrend.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 15/10/2020.
//

import Foundation

struct RecommendationTrend {
    let ratingBuy: Int
    let ratingOverweight: Int
    let ratingHold: Int
    let ratingUnderweight: Int
    let ratingSell: Int
    let ratingScaleMark: Double
    let consensusStartDate: Date?
    let consensusEndDate: Date?
}

extension RecommendationTrend {
    static let random = RecommendationTrend(ratingBuy: 3,
                                            ratingOverweight: 5,
                                            ratingHold: 2,
                                            ratingUnderweight: 1,
                                            ratingSell: 1,
                                            ratingScaleMark: 3.2,
                                            consensusStartDate: Date(),
                                            consensusEndDate: Date())

    init(recommendationTrend: IEXRecommendationTrend) {
        ratingBuy = recommendationTrend.ratingBuy
        ratingOverweight = recommendationTrend.ratingOverweight
        ratingHold = recommendationTrend.ratingHold
        ratingUnderweight = recommendationTrend.ratingUnderweight
        ratingSell = recommendationTrend.ratingSell
        ratingScaleMark = recommendationTrend.ratingScaleMark
        consensusStartDate = recommendationTrend.consensusStartDate != nil ? Date(timeIntervalSince1970: Double(recommendationTrend.consensusStartDate!) / 1000) : nil
        consensusEndDate = recommendationTrend.consensusEndDate != nil ? Date(timeIntervalSince1970: Double(recommendationTrend.consensusEndDate!) / 1000) : nil
    }
}
