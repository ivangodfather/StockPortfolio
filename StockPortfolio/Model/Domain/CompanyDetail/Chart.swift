//
//  Chart.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation

struct Chart {
    let date: String
    let closePrize: Double
}

extension Chart {
    init(chart: IEXChart) {
        self.date = chart.date
        self.closePrize = chart.close
    }
}
