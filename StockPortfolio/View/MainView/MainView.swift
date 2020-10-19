//
//  MainView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 02/10/2020.
//

import SwiftUI
import Combine

struct MainView: View {
    @State private var selected = 0
    let searchViewPublisher = NotificationCenter.default.publisher(for: .searchView)

    var body: some View {
        TabView(selection: $selected) {
            WatchlistsView()
                .tabItem {
                    Image(systemName: "list.star")
                    Text("Your Stocks")
                }.tag(0)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.tag(1)
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("News")
                }.tag(2)
            DiscoverView()
                .tabItem {
                    Image(systemName: "antenna.radiowaves.left.and.right")
                    Text("Discover")
                }.tag(3)
        }.onReceive(searchViewPublisher) { _ in
            self.selected = 1
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
