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
            Rectangle()
                .fill(quoteDetail.quote.change > 0 ? Color.App.green : Color.App.red)
                .frame(width: 6)

            RemoteImage(url: quoteDetail.logo)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 4) {
                Text(quoteDetail.quote.symbol).bold()
                Text(quoteDetail.quote.companyName).font(.caption)
            }
            .layoutPriority(-1)
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(quoteDetail.quote.changePercent)%")
                    .font(.callout).bold()
                Text(quoteDetail.quote.gainLossString).font(.caption)
            }
        }
        .foregroundColor(Color.primary)
        .padding(.vertical, 4)
    }
}

struct QuoteRowView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteRowView(quoteDetail: .random).previewLayout(PreviewLayout.fixed(width: 300, height: 80))
    }
}
