//
//  MainView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 02/10/2020.
//

import SwiftUI
import Combine

struct MainView: View {
    
    var body: some View {
        TabView {
            WatchlistsView()
                .tabItem {
                    Image(systemName: "list.star")
                    Text("Your Stocks")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("News")
                }
            DiscoverView()
                .tabItem {
                    Image(systemName: "antenna.radiowaves.left.and.right")
                    Text("Discover")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
