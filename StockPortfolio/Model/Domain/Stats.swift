//
//  Stats.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import Foundation

struct Stats {
    let dividendYield: Double?
    let week52change: Double
    let week52high: Double
    let week52low: Double
    let year5ChangePercent: Double
    let year2ChangePercent: Double
    let year1ChangePercent: Double
    let peRatio: Double
    let exDividendDate: String?
    let marketcap: Double
}

extension Stats {
    init(stats: IEXStats) {
        dividendYield = stats.dividendYield
        week52change = stats.week52change
        week52high = stats.week52high
        week52low = stats.week52low
        year5ChangePercent = stats.year5ChangePercent
        year2ChangePercent = stats.year2ChangePercent
        year1ChangePercent = stats.year1ChangePercent
        peRatio = stats.peRatio
        exDividendDate =  stats.exDividendDate
        marketcap = stats.marketcap
    }

    static let random = Stats(dividendYield: 2.52,
                              week52change: 23.5,
                              week52high: 545,
                              week52low: 423,
                              year5ChangePercent: 50.25,
                              year2ChangePercent: 15.76,
                              year1ChangePercent: 10.5,
                              peRatio: 2.5,
                              exDividendDate: "2020-20-01",
                              marketcap: 12345678)
}
