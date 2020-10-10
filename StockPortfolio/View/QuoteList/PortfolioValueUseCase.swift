//
//  PortfolioValueUseCase.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 08/10/2020.
//

import Foundation

struct PortfolioValueUseCase {
    static func value(from stockQuotes: [StockQuote]) -> PortfolioValue {
        let currentValue = stockQuotes.map { Double($0.numberOfShares) * $0.quote.latestPrice }.reduce(0,+)
        let todayGain = stockQuotes.map { $0.quote.gainLoss * Double($0.numberOfShares) }.reduce(0, +)
        let portfolioPercentage =   (currentValue - (currentValue - todayGain)) / 100
        return PortfolioValue(currentValue: currentValue,
                              portfolioFractionalValue: currentValue.first2Decimals,
                              portfolioTodayGain: todayGain,
                              portfolioPercentage: portfolioPercentage.round2())
    }
}
