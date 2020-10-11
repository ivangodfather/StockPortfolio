//
//  NewsRowView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 10/10/2020.
//

import SwiftUI

struct NewsRowView: View {

    @State private var showFullDetail = false

    let news: News

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                NewsRowHeadlineView(news: news)
                Spacer()
                AsyncImage(url: news.imageURL) {
                    Image(systemName: "photo.on.rectangle.angled")
                }
                .frame(width: 100, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipped()
            }
            .padding(.vertical, 0)
            .onTapGesture {
                showFullDetail.toggle()
            }
            if showFullDetail {
                Text(news.summary)
                HStack {
                    Link("Go to website", destination: news.url)
                    Text("(Source: \(news.source))")
                }
            }
            Divider()
        }
        .padding()
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowView(news: News.random).previewLayout(.fixed(width: 400, height: 400))
    }
}

struct NewsRowHeadlineView: View {
    let news: News
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text(news.headline).bold().font(.body)
                HStack {
                    Text(news.related)
                    Text(news.dateString)
                }
                .padding(.top)
                .font(.footnote)
            }
            Spacer()
        }
    }
}

struct NewsRowHeadlineView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowHeadlineView(news: News.random).previewLayout(.fixed(width: 400, height: 400))
    }
}
