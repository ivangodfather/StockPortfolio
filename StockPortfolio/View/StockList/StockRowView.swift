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
                Text(stock.companyName).bold().modifier(ColorifyModifier())
                Text(stock.symbol).font(.caption).modifier(ColorifyModifier())
            }.padding(0)
            Spacer()
            VStack(alignment: .trailing) {
                HStack(spacing: 0) {
                    Text("$")
                    Text(stock.latestPrice.description)
                }.font(.headline).modifier(ColorifyModifier())
                Text("\(stock.percentage.round2())%").foregroundColor(stock.percentage > 0 ? .green : .red)
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

struct ColorifyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.black.opacity(0.6))
    }
}
