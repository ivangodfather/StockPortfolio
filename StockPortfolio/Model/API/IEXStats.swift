//
//  IEXStats.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import Foundation

struct IEXStats: Decodable {
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
