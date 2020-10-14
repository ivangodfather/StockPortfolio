//
//  IEXQuoteDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import Foundation

struct IEXQuoteDetail: Decodable {
    let quote: IEXQuote
    let logo: IEXLogo
}
