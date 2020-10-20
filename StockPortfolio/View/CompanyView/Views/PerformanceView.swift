//
//  PerformanceView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 15/10/2020.
//

import SwiftUI

struct PerformanceView: View {
    let stats: Stats
    let latestPrice: Double

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
        GroupBox(label: Title("Performance").padding(.bottom, 16), content: {
            VStack(alignment: .leading) {
                ForEach(performances) { performance in
                    VStack(spacing: 8) {
                        HStack {
                            Text(performance.intervalName)
                                .font(.callout).bold()
                            Spacer()
                            Text(performance.value.round2() + "%")
                                .font(.callout).bold()
                                .frame(width: 80, alignment: .trailing)
                            Rectangle()
                                .frame(width: min(1.5 * CGFloat(abs(performance.value)), 150), height: 15)
                                .frame(width: 150, alignment: .leading)
                                .padding(.trailing)
                                .foregroundColor(.accentColor)
                        }
                        Divider()
                    }
                }
                Week52View(stats: stats, latestPrice: latestPrice)
                    .padding(.vertical)
            }
        }).groupBoxStyle(MyGroupBoxStyle())
    }
}

private struct Performance: Identifiable {
    let intervalName: String
    let value: Double

    var id: String { intervalName }
}

struct PerformanceView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceView(stats: .random, latestPrice: 30)
    }
}
