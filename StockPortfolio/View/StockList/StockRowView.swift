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
                Circle().fill(Color.gray)
                AsyncImage(url: stock.logo) {
                    ProgressView()
                }.frame(width: 48, height: 48)
            }.frame(width: 48, height: 48, alignment: .center)
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.companyName).bold().foregroundColor(Color.Stock.gray)
                Text(stock.symbol + " - " + "\(stock.shares) shares").font(.caption).foregroundColor(Color.Stock.gray)
            }.padding(0)
            Spacer()
            VStack(alignment: .trailing) {
                HStack(spacing: 0) {
                    Text("$")
                    Text(stock.latestPrice.description)
                }.font(.headline).foregroundColor(Color.Stock.gray)
                Text("\(stock.percentage.round2())%").foregroundColor(stock.percentage > 0 ? Color.Stock.green : Color.Stock.red)
                    .font(.body)
            }.padding(.horizontal)
        }
        .padding(.vertical)
    }
}

struct StockRowView_Previews: PreviewProvider {
    static var previews: some View {
        StockRowView(stock: Stock.random)
    }
}
