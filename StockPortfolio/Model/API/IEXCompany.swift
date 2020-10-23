//
//  IEXCompany.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 05/10/2020.
//

import Foundation

struct IEXCompany: Decodable {
    let symbol: String
    let exchange: String
    let industry: String
    let website: URL
    let CEO: String
    let description: String
    let securityName: String
    let issueType: String
    let sector: String
    let employees: Int?
    let tags: [String]
    let country: String
}
