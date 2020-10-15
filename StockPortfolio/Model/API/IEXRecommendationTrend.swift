//
//  IEXRecommendationTrend.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 15/10/2020.
//

import Foundation

struct IEXRecommendationTrend: Decodable {
    let ratingBuy: Int
    let ratingOverweight: Int
    let ratingHold: Int
    let ratingUnderweight: Int
    let ratingSell: Int
    let ratingScaleMark: Double
    let consensusStartDate: Int
    let consensusEndDate: Int
}
