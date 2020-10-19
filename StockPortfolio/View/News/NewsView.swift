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
    
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading: ProgressView()
                case .empty: NoDataView(title: "You don't have any symbols", subtitle: "Add any symbol to a watchlist and start reading news.", button: ("Search symbols", { NotificationCenter.default.post(name: .searchView, object: nil, userInfo: nil) }))
                case .error(let description):
                    NoDataView(title: "Ups, something went wrong",
                               subtitle: description,
                               button: ("Retry", { viewModel.request()}))
                case .loaded(let news):
                    NewsBodyView(news: news)
                }
            }
            .onAppear(perform: viewModel.request)
            .navigationTitle("News")
            .navigationBarItems(trailing: Button(action: { self.viewModel.request() }, label: {
                Image(systemName: "arrow.clockwise.circle").imageScale(.large)
            }))
        }
    }
}
