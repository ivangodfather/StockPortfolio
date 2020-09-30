//
//  StockDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import SwiftUICharts
import Combine

struct StockDetail: View {
    var stock: Stock

    @StateObject private var viewModel = StockDetailViewModel()
    @State private var selectedPeriod = 0

    var body: some View {
        ScrollView {
            VStack() {
                Picker(selection: $selectedPeriod, label: Text("Select")) {
                    ForEach(0..<ChartPeriod.allCases.count) {
                        Text(ChartPeriod.allCases[$0].rawValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedPeriod) {
                    viewModel.chart(from: stock.symbol, selectedPeriod: $0)
                }
            }
            .padding()
            if !viewModel.chartData.isEmpty {
                LineChartView(data: viewModel.chartData, title: "", form: ChartForm.large,rateValue: viewModel.percentageIncrease)
            } else {
                ProgressView()
                .onAppear {
                    viewModel.chart(from: stock.symbol, selectedPeriod: selectedPeriod)
                }
            }
            Divider().padding(.vertical, 16)
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
}

struct StockDetail_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail(stock: Stock(symbol: "AAPL", companyName: "Apple Inc.", latestPrice: 100, previousClose: 90, logo: URL(string: "https://www.apple.com/euro/retail/home/d/generic/images/og.jpg?202008110017")!, news: [Stock.News(headline: "Headline!", source: "Any Source", url: URL(string: "https://www.google.com/")!, summary: "Any summary")]))
    }
}
