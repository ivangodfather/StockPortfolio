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
                ForEach(Array(news.enumerated()), id: \.0) { index, news in
                    NavigationLink(
                        destination: WebViewWrapper(url: news.url),
                        label: {
                            NewsRowView(news: news)
                                .background(index.isMultiple(of: 2) ? Color.App.background : Color.clear)
                        })
                }
            }
        }
    }
}

struct NewsBodyView_Previews: PreviewProvider {
    static var previews: some View {
        NewsBodyView(news: [News.random, News.random]).previewLayout(.sizeThatFits)
    }
}

struct NewsBodyView_Previews_Dark: PreviewProvider {
    static var previews: some View {
        NewsBodyView(news: [News.random, News.random]).preferredColorScheme(.dark).previewLayout(.sizeThatFits)
    }
}

import WebKit
final class WebViewWrapper: UIViewRepresentable {
    let request: URLRequest

    init(url: URL) {
        request = URLRequest(url: url)
    }

    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(request)
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {

    }
}
