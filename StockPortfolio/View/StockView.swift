//
//  StockView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import Foundation

struct StockRowView: View {
    var stock: Stock

    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "power")
                AsyncImage(url: stock.logo) {
                    ProgressView()
                }.frame(width: 48, height: 48)
            }.frame(width: 48, height: 48, alignment: .center)
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.companyName).bold()
                Text(stock.symbol).font(.caption)
            }
            Spacer()
            VStack(alignment: .trailing) {
                HStack(spacing: 0) {
                    Text("$")
                    Text(stock.latestPrice.description)
                }.font(.headline)
                Text("\(stock.percentage.round2())%").foregroundColor(stock.percentage > 0 ? .green : .red)
                    .font(.caption).bold()
            }
        }
        .padding(.vertical)
    }
}

struct StockRowView_Previews: PreviewProvider {
    static var previews: some View {
        StockRowView(stock: Stock(symbol: "AAPL", companyName: "Apple Inc.", latestPrice: 100, previousClose: 90, logo: URL(string: "https://www.apple.com/euro/retail/home/d/generic/images/og.jpg?202008110017")!))
    }
}
