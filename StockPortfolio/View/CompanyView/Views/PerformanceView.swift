//
//  PerformanceView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 15/10/2020.
//

import SwiftUI

struct PerformanceView: View {
    let stats: Stats

    fileprivate var performances: [Performance] {
        [
            Performance(intervalName: "5 day", value: stats.day5ChangePercent),
            Performance(intervalName: "1 month", value: stats.month1ChangePercent),
            Performance(intervalName: "3 months", value: stats.month3ChangePercent),
            Performance(intervalName: "6 months", value: stats.month6ChangePercent),
            Performance(intervalName: "YTD", value: stats.ytdChangePercent),


        ]
    }

    var body: some View {
        VStack(alignment: .leading) {
            Title("Performance")
            ForEach(performances) { performance in
                VStack(spacing: 8) {
                    HStack {
                        Text(performance.intervalName)
                        Spacer()
                        Text(performance.value.round2() + "%")
                            .frame(width: 80, alignment: .trailing)
                        Rectangle()
                            .frame(width: min(1.5 * CGFloat(performance.value), 150), height: 15)
                            .frame(width: 150, alignment: .leading)
                            .padding(.trailing)
                            .foregroundColor(stats.month1ChangePercent < 0 ? Color.Stock.red : Color.Stock.green)
                    }
                    Divider()
                }
            }
        }
        .padding(.horizontal)
    }
}

private struct Performance: Identifiable {
    let intervalName: String
    let value: Double

    var id: String { intervalName }
}

struct PerformanceView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceView(stats: .random)
    }
}
