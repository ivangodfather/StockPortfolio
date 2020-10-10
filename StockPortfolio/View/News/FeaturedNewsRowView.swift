//
//  FeaturedNewsRowView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 10/10/2020.
//

import SwiftUI

struct FeaturedNewsRowView: View {
    let news: News

    var body: some View {
        ZStack(alignment: Alignment.init(horizontal: .leading, vertical: .bottom)) {
            AsyncImage(url: news.imageURL) {
                Color.white
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 180).clipped()
            NewsRowHeadlineView(news: news)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [.black, Color.black.opacity(0.5)]), startPoint: .bottom, endPoint: .top))
        }
    }
}

struct FeaturedNewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedNewsRowView(news: News.random)
            .previewLayout(.fixed(width: 300, height: 200))
    }
}
