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
            VStack(alignment: .leading, spacing: 8) {
                ForEach(news) { news in
                    DisclosureGroup(news.headline) {
                        VStack {
                            HStack {
                                AsyncImage(url: URL(string: news.image)!) {
                                    ProgressView()
                                }
                                Text("Source: " + news.source).bold()
                                Link("Go to website", destination: news.url)
                            }.padding(.vertical)
                            .font(.callout)
                            Text(news.summary)
                        }.padding(.vertical)
                    }
                }
                Divider()
            }
        }
    }
}

struct NewsBodyView_Previews: PreviewProvider {
    static var previews: some View {
        NewsBodyView(news: [News.random])
    }
}
