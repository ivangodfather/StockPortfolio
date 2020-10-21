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
                    .border(Color.accentColor, width: 3)
                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                .clipped()
            }
        }
        .padding()
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NewsRowView(news: News.random)

        }.previewLayout(.fixed(width: 400, height: 400))
    }
}

struct NewsRowView2_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NewsRowView(news: News.random)

        }.previewLayout(.fixed(width: 400, height: 400)).preferredColorScheme(.dark)
    }
}
