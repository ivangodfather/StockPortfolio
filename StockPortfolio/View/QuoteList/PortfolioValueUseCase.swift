//
//  PortfolioValueUseCase.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 08/10/2020.
//

import Foundation

struct PortfolioValueUseCase {
    static func value(from stocks: [Stock], withQuotes quotes: [Quote]) -> PortfolioValue {
        let totalValue = stocks.map { stock in
            (quotes.first { $0.symbol == stock.symbol }?.latestPrice ?? 0) * Double(stock.shares)
        }.reduce(0,+)
        return PortfolioValue(portfolioTotalValue: Int(totalValue),
                              portfolioFractionalValue: totalValue.first2Decimals,
                              portfolioTodayGain: 3,
                              portfolioPercentage: 3.55)
    }
}
