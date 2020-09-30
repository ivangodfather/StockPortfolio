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
}
