//
//  PortfolioValueUseCase.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 08/10/2020.
//

import Foundation

struct PortfolioValueUseCase {
    static func value(from stockQuotes: [StockQuote]) -> PortfolioValue {
        let totalValue = stockQuotes.map { Double($0.numberOfShares) * $0.quote.latestPrice }.reduce(0,+)
        return PortfolioValue(portfolioTotalValue: Int(totalValue),
                              portfolioFractionalValue: totalValue.first2Decimals,
                              portfolioTodayGain: 3,
                              portfolioPercentage: 3.55)
    }
}
