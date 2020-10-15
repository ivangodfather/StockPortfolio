//
//  Week52View.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 15/10/2020.
//

import SwiftUI

struct Week52View: View {

    let stats: Stats
    let latestPrice: Double

    var body: some View {
        HStack(spacing: 24) {
            Text("52 Week H/L").foregroundColor(Color.Stock.gray).bold()
            VStack(alignment: .leading) {
                GeometryReader { reader in
                    VStack(spacing: 0) {
                        Text(latestPrice.round2()).font(.system(size: 11))
                        Image(systemName: "arrowtriangle.down")
                            .imageScale(.small)
                            .foregroundColor(.blue)
                    }.offset(x: calculateOffset(width: reader.size.width) - 19, y: -4)
                }.frame(height: 15)
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 8)
                HStack {
                    Text(stats.week52low.round2())
                        .foregroundColor(Color.Stock.red)
                    Spacer()
                    Text(stats.week52high.round2())
                        .foregroundColor(Color.Stock.green)
                }.font(.footnote)
            }
        }
    }

    private func calculateOffset(width: CGFloat) -> CGFloat {
        let increment = (latestPrice - stats.week52low) / (stats.week52high - stats.week52low)
        return min(width * CGFloat(increment), width)
    }
}

struct Week52View_Previews: PreviewProvider {
    static var previews: some View {
        Week52View(stats: .random, latestPrice: 150)
    }
}
