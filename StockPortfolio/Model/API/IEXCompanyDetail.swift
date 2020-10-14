//
//  IEXCompanyDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import Foundation

struct IEXCompanyDetail: Decodable {
    let company: IEXCompany
    let news: [IEXNews]
    let stats: IEXStats
    let logo: IEXLogo
}
