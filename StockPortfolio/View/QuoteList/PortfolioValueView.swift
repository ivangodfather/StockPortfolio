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
                    Text(Int(portfolioValue.currentValue).description)
                        .font(Font.system(size: 56, weight: .medium, design: .monospaced))
                    Text(portfolioValue.portfolioFractionalValue.description)
                        .font(Font.system(size: 32, weight: .light, design: .monospaced))

                }
                HStack(spacing: 8) {
                    Text("$\(portfolioValue.portfolioTodayGain.round2())")
                    Text("(\(portfolioValue.portfolioPercentage)%)")
                    Text("TODAY")
                }
                .font(Font.system(size: 16, weight: .light, design: .monospaced))
                .foregroundColor(portfolioValue.portfolioTodayGain > 0 ? Color.Stock.green : Color.Stock.red)
            }
            .padding()
        } else {
            ProgressView()
        }
    }
}

struct PortfolioValue {
    let currentValue: Double
    let portfolioFractionalValue: String
    let portfolioTodayGain: Double
    let portfolioPercentage: String
}

struct StockValueView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioValueView(portfolioValue: PortfolioValue.random)
    }
}
