//
//  QuoteDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import Foundation


struct QuoteDetail {
    let quote: Quote
    let logo: URL
}

extension QuoteDetail {
    init(quoteDetail: IEXQuoteDetail) {
        quote = Quote(quote: quoteDetail.quote)
        logo = quoteDetail.logo.url
    }

    static let random = QuoteDetail(quote: .random, logo: .random)
}
