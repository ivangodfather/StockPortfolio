//
//  NewsViewBody.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 03/10/2020.
//

import SwiftUI

struct NewsBodyView: View {
    let news: [News]
    var body: some View {
        ScrollView {
            VStack {
                ForEach(news) {
                    if !$0.isFeatured {
                        FeaturedNewsRowView(news: $0)
                    } else {
                        NewsRowView(news: $0)
                    }
                }
            }
        }
    }
}

struct NewsBodyView_Previews: PreviewProvider {
    static var previews: some View {
        NewsBodyView(news: [News.random, News.random])
    }
}
