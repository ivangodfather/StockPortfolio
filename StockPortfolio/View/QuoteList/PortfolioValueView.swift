//
//  StockValueView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import SwiftUI

struct PortfolioValueView: View {

    var portfolioValue: PortfolioValue?

    var body: some View {
        if let portfolioValue = portfolioValue {
            VStack {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("$")
                        .font(Font.system(size: 32, weight: .light, design: .monospaced))
                    Text(portfolioValue.portfolioTotalValue.withDotSeparator)
                        .font(Font.system(size: 56, weight: .medium, design: .monospaced))
                    Text("," + portfolioValue.portfolioFractionalValue.description)
                        .font(Font.system(size: 32, weight: .light, design: .monospaced))

                }
                HStack(spacing: 8) {
                    Text("+$\(portfolioValue.portfolioTodayGain)").foregroundColor(Color.Stock.green)
                    Text("(\(portfolioValue.portfolioPercentage.round2())%)").foregroundColor(Color.Stock.green)
                    Text("TODAY")
                }
                .font(Font.system(size: 16, weight: .light, design: .monospaced))
            }
            .padding()
        } else {
            ProgressView()
        }
    }
}

struct PortfolioValue {
    let portfolioTotalValue: Int
    let portfolioFractionalValue: String
    let portfolioTodayGain: Int
    let portfolioPercentage: Double
}

struct StockValueView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioValueView(portfolioValue: PortfolioValue.random)
    }
}

// TODO
//struct PortfolioValueUseCase {
//    static func value(from stocks: [StockDetail]) -> PortfolioValue {
//        let total = stocks.map { $0.latestPrice * Double($0.shares) }.reduce(0,+)
//        let fractional = String(modf(total).1.description.prefix(4).suffix(2))
//        return PortfolioValue(portfolioTotalValue: Int(total), portfolioFractionalValue: fractional, portfolioTodayGain: 3, portfolioPercentage: 3.55)
//    }
//}
