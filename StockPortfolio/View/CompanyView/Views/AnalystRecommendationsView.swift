//
//  RecommendationView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 15/10/2020.
//

import Foundation
import SwiftUI

struct AnalystRecommendationsView: View {

    let rating: Double

    init(rating: Double) {
        self.rating = rating
    }

    private var ratings = ["1\nBuy", "2\nOutperform", "3\nHold", "4\nUnderperform", "5\nSell"]

    var body: some View {
        VStack {
            Title("Analyst Recommendations").padding()
            VStack(alignment: .leading, spacing: 0) {
                Rectangle().fill(Color.Stock.gray).frame(height: 4).offset(y: 10)
                GeometryReader { geo in
                    HStack {
                        ForEach(ratings, id: \.self) { rating in
                            HStack {
                                Rectangle()
                                    .frame(width: 2, height: 16)
                                    .background(Text(rating)
                                                    .fixedSize()
                                                    .multilineTextAlignment(.center)
                                                    .offset(x: 0, y: 26)
                                    )
                                if rating != ratings.last {                            Spacer()
                                }
                            }
                        }
                        .foregroundColor(Color.Stock.gray)
                        .font(.footnote)
                    }.overlay(
                        ToolTip(text: rating.description).offset(x: calculateOffset(width: geo.size.width), y: -22)
                            .alignmentGuide(HorizontalAlignment.leading) {
                                $0[HorizontalAlignment.center]
                            }, alignment: .leading
                    )
                }

            }.padding(.horizontal, 32)
        }.frame(height: 150)
    }

    private func calculateOffset(width: CGFloat) -> CGFloat {
        width * CGFloat((Double(rating) - 1) / 4)
    }
}

struct AnalystRecommendationsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalystRecommendationsView(rating: 4.8)
    }
}
