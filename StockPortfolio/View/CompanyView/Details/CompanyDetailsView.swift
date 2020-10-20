//
//  CompanyDetailsView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import SwiftUI

struct CompanyDetailsView: View {
    let companyDetail: CompanyDetail

    var body: some View {
        ScrollView {
            VStack {
//                ChartView(symbol: companyDetail.quote.symbol)
                PriceTargetView(priceTarget: companyDetail.priceTarget, currentPrice: companyDetail.quote.latestPrice)
                AnalystRecommendationsView(rating: companyDetail.recommendationTrend.first!.ratingScaleMark)
                PerformanceView(stats: companyDetail.stats,
                                latestPrice: companyDetail.quote.latestPrice)
                DisplayTextView(title: "Description", content: companyDetail.company.description)
            }
        }
    }
}

struct CompanyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailsView(companyDetail: .random)
    }
}
