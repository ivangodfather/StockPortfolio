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
            RemoteImage(url: news.imageURL)
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 200)
            HStack {
                NewsRowHeadlineView(news: news)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width)
                    .foregroundColor(.primary)
                    .background(LinearGradient(gradient: Gradient(colors: [.black, Color.black.opacity(0.5)]), startPoint: .bottom, endPoint: .top))
            }
        }
        .clipped()
    }
}

struct FeaturedNewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedNewsRowView(news: News.random).previewLayout(.fixed(width: 400, height: 250))
    }
}

struct FeaturedNewsRowView_Previews2: PreviewProvider {
    static var previews: some View {
        FeaturedNewsRowView(news: News.random).preferredColorScheme(.dark).previewLayout(.fixed(width: 400, height: 250))
    }
}
