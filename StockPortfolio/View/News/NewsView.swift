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
    @State private var selectedNews = 0

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Picker(selection: $selectedNews, label: Text("Choose")) {
                        ForEach(NewsType.allCases, id: \.rawValue) { newsType in
                            Text(newsType.description).tag(newsType.rawValue)
                        }

                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    if stocks.isEmpty {
                        ProgressView()
                    } else {
                        NewsBodyView(news: viewModel.news).onAppear {
                            self.viewModel.request(symbols: stocks.map { $0.symbol ?? "" })
                        }
                        .navigationBarTitle(Text("News"))
                    }
                }
                .padding()

            }
        }.onChange(of: selectedNews) { selectedNews in
            switch selectedNews {
            case NewsType.yourStocks.rawValue:
                self.viewModel.request(symbols: stocks.map { $0.symbol ?? "" })
            default :
                self.viewModel.request(symbols: [])
            }
        }
    }
}
