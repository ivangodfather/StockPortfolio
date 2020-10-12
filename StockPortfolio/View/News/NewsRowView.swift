//
//  NewsRowView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 10/10/2020.
//

import SwiftUI

struct NewsRowView: View {
    let news: News

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                NewsRowHeadlineView(news: news)
                Spacer()
                RemoteImage(url: news.imageURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                .clipped()
            }
        }
        .foregroundColor(Color.Stock.gray)
        .padding()
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowView(news: News.random).previewLayout(.fixed(width: 400, height: 400))
    }
}
