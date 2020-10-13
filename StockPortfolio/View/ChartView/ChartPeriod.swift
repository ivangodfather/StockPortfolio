//
//  ChartPeriod.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation

enum ChartPeriod: String, CaseIterable {
    case months3 = "3m"
    case months6 = "6m"
    case years1 = "1y"
    case years2 = "2y"
    case years5 = "5y"

    var interval: String {
        switch self {
        case .months3: return "10"
        case .months6: return "15"
        case .years1: return "20"
        case .years2: return "25"
        case .years5: return "30"
        }
    }
    
}
