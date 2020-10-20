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

    @State var toolTipSize = CGSize.zero

    private var ratings = ["1\nBuy", "2\nOutperform", "3\nHold", "4\nUnderperform", "5\nSell"]

    var body: some View {
        GroupBox(label: Title("Analyst Recommendations").padding(.bottom, 32)) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle().fill(Color.secondary).frame(height: 4).offset(y: 10)
                    HStack {
                        ForEach(ratings, id: \.self) { rating in
                            VStack {
                                Rectangle()
                                    .frame(width: 2, height: 16)
                                    .overlay(
                                        Text(rating)
                                            .multilineTextAlignment(.center)
                                            .fixedSize()
                                            .offset(y: 30)
                                            .foregroundColor(.white)
                                    )
                            }
                            if rating != ratings.last {
                                Spacer()
                            }
                        }
                        .foregroundColor(Color.secondary)
                        .font(.footnote)
                    }.background(
                        GeometryReader { geo in
                            ToolTip(text: rating.round2())
                                .background(GeometryReader { toolTipGeo  in
                                    Color.clear.onAppear {
                                        toolTipSize = toolTipGeo.size
                                    }
                                })
                                .offset(x: calculateOffset(width: geo.size.width), y: -toolTipSize.height)
                        }, alignment: .leading)

                }
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }.groupBoxStyle(MyGroupBoxStyle())

    }

    private func calculateOffset(width: CGFloat) -> CGFloat {
        -(toolTipSize.width / 2) + width * CGFloat((Double(rating) - 1) / 4)
    }
}

struct AnalystRecommendationsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalystRecommendationsView(rating: 3.5)
    }
}
