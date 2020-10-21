//
//  Double+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import Foundation

extension Double {
    func round2() -> String {
        String(format: "%.2f", self)
    }

    func percentage(from initialValue: Double) -> Double {
        ((self - initialValue) * 100 / initialValue)
    }

    var first2Decimals: String {
        String(modf(self).1.description.prefix(4).suffix(2))
    }

    var withSign: String {
        let symbol = self > 0 ? "+" : ""
        return symbol + self.round2()
    }
}
