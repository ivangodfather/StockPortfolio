//
//  StockView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import Foundation

struct QuoteRowView: View {
    var quoteDetail: QuoteDetail

    var body: some View {
        HStack {
            RemoteImage(url: quoteDetail.logo)
                .frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: 4) {
                Text("\(quoteDetail.quote.companyName) (\(quoteDetail.quote.symbol))").bold().font(.callout)
                HStack {
                    Text(quoteDetail.quote.latestPrice.round2())
                }.font(.footnote)
            }.layoutPriority(-1)
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(quoteDetail.quote.changePercent)%")
                    .font(.callout).bold()
            }.foregroundColor(quoteDetail.quote.percentage >= 0 ? Color.Stock.green : Color.Stock.red)

        }
        .padding(.vertical)
    }
}

struct QuoteRowView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteRowView(quoteDetail: .random).previewLayout(PreviewLayout.fixed(width: 300, height: 100))
    }
}
