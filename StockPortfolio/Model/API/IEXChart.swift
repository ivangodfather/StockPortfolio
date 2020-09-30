//
//  IEXChart.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation

struct IEXChart: Decodable {
    let date: String
    let close: Double
}

extension Chart {
    init(chart: IEXChart) {
        self.date = chart.date
        self.closePrize = chart.close
    }
}
