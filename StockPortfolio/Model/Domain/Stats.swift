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
    let ytdChangePercent: Double
    let month6ChangePercent: Double
    let month3ChangePercent: Double
    let month1ChangePercent: Double
    let day5ChangePercent: Double
    let peRatio: Double
    let exDividendDate: String?
    let marketcap: Double
    let sharesOutstanding: Int
    let nextEarningsDate: String
    let avg30Volume: Double
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
        sharesOutstanding = stats.sharesOutstanding
        nextEarningsDate = stats.nextEarningsDate
        avg30Volume = stats.avg30Volume
        ytdChangePercent = stats.ytdChangePercent * 100
        month6ChangePercent = stats.month6ChangePercent * 100
        month3ChangePercent = stats.month3ChangePercent * 100
        month1ChangePercent = stats.month1ChangePercent * 100
        day5ChangePercent = stats.day5ChangePercent * 100
    }

    static let random = Stats(dividendYield: 2.52,
                              week52change: 23.5,
                              week52high: 545,
                              week52low: 423,
                              year5ChangePercent: 50.25,
                              year2ChangePercent: 15.76,
                              year1ChangePercent: 10.5,
                              ytdChangePercent: 25.5,
                              month6ChangePercent: 20.5,
                              month3ChangePercent: 15.23,
                              month1ChangePercent: 10.3,
                              day5ChangePercent: 2.1,
                              peRatio: 2.5,
                              exDividendDate: "2020-10-01",
                              marketcap: 12345678,
                              sharesOutstanding: 123456789,
                              nextEarningsDate: "2020-20-05",
                              avg30Volume: 35321.23)
}
