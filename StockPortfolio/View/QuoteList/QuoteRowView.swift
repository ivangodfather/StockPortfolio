//
//  StockView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import Foundation

struct QuoteRowView: View {

    private let quoteDetail: QuoteDetail

    init(quoteDetail: QuoteDetail) {
        self.quoteDetail = quoteDetail
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
                        Text("$" + quoteDetail.quote.latestPrice.round2()).bold().font(.callout)
                    }
                    VStack(alignment: .trailing) {
                        Text("\(quoteDetail.quote.changePercent.withSign)%")
                            .font(.callout).bold()
                        Text(quoteDetail.quote.change.withSign)
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
        QuoteRowView(quoteDetail: .random).previewLayout(.sizeThatFits)
    }
}
