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
            Text("52 Week H/L").foregroundColor(.white).bold()
            VStack(alignment: .leading) {
                GeometryReader { reader in
                    VStack(spacing: 0) {
                        Text(latestPrice.round2())
                            .font(.callout)
                            .bold()
                            .foregroundColor(.accentColor)
                        Image(systemName: "arrowtriangle.down")
                            .imageScale(.small)
                            .foregroundColor(.accentColor)
                    }.offset(x: calculateOffset(width: reader.size.width) - 19, y: -8)
                }.frame(height: 15)
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 8)
                HStack {
                    Text(stats.week52low.round2())
                    Spacer()
                    Text(stats.week52high.round2())
                }.font(.footnote)
            }
            .foregroundColor(.white)
        }.frame(height: 72)
    }

    private func calculateOffset(width: CGFloat) -> CGFloat {
        let increment = (latestPrice - stats.week52low) / (stats.week52high - stats.week52low)
        return min(width * CGFloat(increment), width)
    }
}

struct Week52View_Previews: PreviewProvider {
    static var previews: some View {
        Week52View(stats: .random, latestPrice: 29).background(Color.gray)
    }
}
