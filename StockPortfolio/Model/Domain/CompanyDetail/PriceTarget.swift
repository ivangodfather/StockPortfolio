//
//  PriceTarget.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 17/10/2020.
//

import Foundation

struct PriceTarget {
    let average: Double
    let high: Double
    let low: Double
    let numberOfAnalysts: Int
}

extension PriceTarget {

    static let random = PriceTarget(average: 210.10, high: 300.05, low: 199.99, numberOfAnalysts: 8)

    init(priceTarget: IEXPriceTarget) {
        average = priceTarget.priceTargetAverage
        low = priceTarget.priceTargetLow
        high = priceTarget.priceTargetHigh
        numberOfAnalysts = priceTarget.numberOfAnalysts
    }
}
