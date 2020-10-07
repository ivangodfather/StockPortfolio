//
//  IEXLogo.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 05/10/2020.
//

import Foundation

struct IEXLogoResponse: Decodable {
    let logo: IEXLogo
}

struct IEXLogo: Decodable {
    let url: URL
}
