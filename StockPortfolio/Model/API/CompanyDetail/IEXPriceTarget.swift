//
//  IEXPriceTarget.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 17/10/2020.
//

import Foundation

struct IEXPriceTarget: Decodable {
    let priceTargetAverage: Double
    let priceTargetHigh: Double
    let priceTargetLow: Double
    let numberOfAnalysts: Int
}
