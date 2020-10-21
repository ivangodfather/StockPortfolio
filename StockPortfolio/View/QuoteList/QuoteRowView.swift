//
//  StockView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import Foundation

private struct MarketPrice {
    private let quoteDetail: QuoteDetail
    private let useExtendedHours: Bool

    init(quoteDetail: QuoteDetail, useExtendedHours: Bool) {
        self.quoteDetail = quoteDetail
        self.useExtendedHours = useExtendedHours
    }

    var change: Double {
        !useExtendedHours ? quoteDetail.quote.change : quoteDetail.quote.extendedChange
    }

    var changePercent: Double {
        !useExtendedHours ? quoteDetail.quote.changePercent : quoteDetail.quote.extendedChangePercent
    }

    var price: Double {
        !useExtendedHours ? quoteDetail.quote.latestPrice : quoteDetail.quote.extendedPrice
    }

}

struct QuoteRowView: View {

    private let quoteDetail: QuoteDetail
    private let useExtendedHours: Bool
    private let marketPrice: MarketPrice

    init(quoteDetail: QuoteDetail, useExtendedHours: Bool) {
        self.quoteDetail = quoteDetail
        self.useExtendedHours = useExtendedHours
        marketPrice = MarketPrice(quoteDetail: quoteDetail, useExtendedHours: useExtendedHours)
    }

    private var priceColor: Color {
        !useExtendedHours ? Color.primary : Color.yellow
    }
    private var gainColor: Color {
        quoteDetail.quote.change > 0 ? Color.App.green : Color.App.red
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Rectangle()
                    .fill(gainColor)
                    .frame(width: 6, height: 64)
                HStack(alignment: .top) {
                    RemoteImage(url: quoteDetail.logo)
                        .frame(width: 48, height: 48)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(quoteDetail.quote.symbol).bold()
                        Text(quoteDetail.quote.companyName).font(.caption)
                    }
                    .layoutPriority(-1)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("$" + marketPrice.price.round2()).bold().font(.callout)
                            .foregroundColor(priceColor)
                    }
                    VStack(alignment: .trailing) {
                        Text("\(marketPrice.changePercent.withSign)%")
                            .font(.callout).bold()
                        Text(marketPrice.change.withSign)
                            .font(.caption).bold()
                    }
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .frame(width: 72)
                    .foregroundColor(gainColor)
                }.padding(.vertical, 4)

            }
            .foregroundColor(Color.primary)
        }
    }
}

struct QuoteRowView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteRowView(quoteDetail: .random,
                     useExtendedHours: true).previewLayout(.sizeThatFits)
    }
}
