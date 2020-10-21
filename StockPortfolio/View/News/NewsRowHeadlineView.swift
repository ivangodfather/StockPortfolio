//
//  NewsRowHeadlineView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 12/10/2020.
//

import SwiftUI

struct NewsRowHeadlineView: View {
    let news: News
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text(news.headline).bold().font(.title3)
                HStack {
                    Text(news.related)
                    Text("\(news.dateString) on \(news.source)")
                        .font(.footnote)
                }
                .padding(.top)
                .font(.footnote)
            }
            Spacer()
        }
        .foregroundColor(.primary)
    }
}

struct NewsRowHeadlineView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowHeadlineView(news: News.random).previewLayout(.fixed(width: 400, height: 400))
    }
}
