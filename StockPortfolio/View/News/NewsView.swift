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
                NewsBodyView(news: viewModel.news)
                    .navigationBarTitle(Text("News"))
            }
        }.onAppear {
            self.viewModel.request(symbols: stocks.map { $0.symbol ?? "" })
        }
    }
}
