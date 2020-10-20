//
//  Numeric+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 20/10/2020.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
