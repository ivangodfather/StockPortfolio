//
//  QuoteDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import Foundation


struct QuoteDetail: Identifiable {
    let quote: Quote
    let logo: URL

    var id: String { quote.id }
}

extension QuoteDetail {
    init(quoteDetail: IEXQuoteDetail) {
        quote = Quote(quote: quoteDetail.quote)
        logo = quoteDetail.logo.url
    }

    static let random = QuoteDetail(quote: .random, logo: .random)
}
