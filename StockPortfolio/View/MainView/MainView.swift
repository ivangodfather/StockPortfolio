//
//  MainView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 02/10/2020.
//

import SwiftUI

struct MainView: View {


    var body: some View {
        TabView {
            StockListView()
                .tabItem {
                    Image(systemName: "list.star")
                    Text("Your Stocks")
                }
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("News")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
