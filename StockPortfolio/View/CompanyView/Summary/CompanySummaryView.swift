//
//  CompanyBodyView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 13/10/2020.
//

import Foundation
import SwiftUI

struct CompanySummaryView: View {
    
    let companyDetail: CompanyDetail

    var companyInfo: [(key: String, value: String)] {  [
        ("Symbol", companyDetail.company.symbol),
        ("Exchange", companyDetail.company.exchange),
        ("Industry", companyDetail.company.industry),
        ("CEO", companyDetail.company.ceo),
        ("Employees", companyDetail.company.employees.description),
        ("Country", companyDetail.company.country),
    ] }

    let rows: [GridItem] =  [
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            GroupBox(label: EmptyView(), content: {
                Group {
                    HStack(spacing: 16) {
                        RemoteImage(url: companyDetail.logo)
                            .frame(width: 100, height: 100)
                        VStack(alignment: .leading) {
                            Text(companyDetail.quote.companyName).font(.title3).bold()
                            Label(companyDetail.quote.latestPrice.round2(), systemImage: "dollarsign.square")
                            Label(companyDetail.quote.percentageString, systemImage: "arrow.up")
                            Label(companyDetail.quote.latestUpdateString, systemImage: "clock")
                        }
                    }

                }.padding(.vertical, 4)
                .font(Font.headline.weight(.semibold))


            })
            .groupBoxStyle(MyGroupBoxStyle())
            TagsView(tags: companyDetail.company.tags)
            KeyDataView(stats: companyDetail.stats)
            DetailListView(title: "About", data: companyInfo)
        }
    }
}

struct CompanyBodyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanySummaryView(companyDetail: .random)
    }


}
