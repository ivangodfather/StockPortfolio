//
//  StockDetailNews.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation
import SwiftUI
import CoreData

struct NewsView: View {

    @FetchRequest(entity: StockCoreData.entity(), sortDescriptors: [])
    var stocks: FetchedResults<StockCoreData>

    @StateObject private var viewModel = NewsViewModel()

    var body: some View {
        NavigationView {
            if stocks.isEmpty {
                ProgressView()
            } else {
                NewsBody(news: viewModel.news).onAppear {
                    self.viewModel.viewDidAppear(symbols: stocks.map { $0.symbol ?? "" })
                }
                .padding()
                .navigationBarTitle(Text("📰 News"))
            }
        }
    }
}

struct NewsBody: View {
    let news: [News]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(news) { news in
                    DisclosureGroup(news.headline) {
                        VStack {
                            HStack {
                                AsyncImage(url: URL(string: news.image)!) {
                                    ProgressView()
                                }
                                Text("Source: " + news.source).bold().foregroundColor(Color.Stock.gray)
                                Link("Go to website", destination: news.url).foregroundColor(Color.Stock.gray)
                            }.padding(.vertical)
                            .font(.callout)
                            Text(news.summary).foregroundColor(Color.Stock.gray)
                        }.padding(.vertical)
                    }
                }
                Divider()
            }
        }
    }
}
