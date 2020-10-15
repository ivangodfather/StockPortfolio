//
//  Week52View.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 15/10/2020.
//

import SwiftUI

struct Week52View: View {
    let companyDetail: CompanyDetail

    private var stats: Stats { companyDetail.stats }

    var body: some View {
        HStack(spacing: 16) {
            Text("52 Week H/L").foregroundColor(Color.Stock.gray).bold()
            VStack(alignment: .leading) {
                GeometryReader { reader in
                    Image(systemName: "arrowtriangle.down")
                        .imageScale(.small)
                        .offset(x: calculateOffset(width: reader.size.width) - 8, y: 8)
                        .foregroundColor(.blue)
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
        }.padding()
    }

    private func calculateOffset(width: CGFloat) -> CGFloat {
        let increment = (200 - stats.week52low) / (stats.week52high - stats.week52low)
        return width * CGFloat(increment)
    }
}

struct Week52View_Previews: PreviewProvider {
    static var previews: some View {
        Week52View(companyDetail: .random)
    }
}
