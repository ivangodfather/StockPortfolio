//
//  StockDetailNews.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation
import SwiftUI

struct StockDetailNews: View {
    var stock: Stock
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("News").font(.title)
            ForEach(stock.news) { news in
                DisclosureGroup(news.headline) {
                    VStack {
                        HStack {
                            Text("Source: " + news.source).bold()
                            Link("Go to website", destination: news.url)
                        }.padding(.vertical)
                        .font(.callout)
                        Text(news.summary)
                    }.padding(.vertical)
                }
            }
            Divider()
        }
        .padding()
        .navigationTitle(stock.companyName)
    }
}
