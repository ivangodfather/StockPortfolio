//
//  CompanyBodyView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 13/10/2020.
//

import Foundation
import SwiftUI

struct CompanyBodyView: View {
    
    let company: Company
    let logoURL: URL

    var companyInfo: [(key: String, image: String, value: String)] {  [
        ("Symbol", "textformat.abc", company.symbol),
        ("Exchange", "dollarsign.square", company.exchange),
        ("Industry", "wrench", company.industry),
        ("CEO", "figure.wave", company.ceo),
        ("Employees", "person.3", company.employees.description),
        ("Country", "flag", company.country),
    ] }

    let rows: [GridItem] =  [
        GridItem(.flexible())
    ]

    var body: some View {
        List {
            RemoteImage(url: logoURL)
                .aspectRatio(contentMode: .fill)
                .padding()
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows) {
                    if let tags = company.tags {
                        ForEach(tags, id: \.self) { tag in
                            Text(tag)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 16).fill(Color.Stock.gray)
                                ).font(.footnote)
                                .foregroundColor(.white)
                        }
                    }
                }
            }.padding(.vertical)
            Section(header: Text("About")) {
                Text(company.description)
                    .padding(.bottom)
            }
            Section(header: Text("Company details")) {
                ForEach(companyInfo, id: \.self.0) { companyInfo in
                    HStack(alignment: .top, spacing: 4) {
                        Text("\(companyInfo.key): ")
                        Text("\(companyInfo.value)").bold()
                    }
                }
            }
        }
    }
}

struct CompanyBodyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyBodyView(company: .random, logoURL: .random)
    }
}
