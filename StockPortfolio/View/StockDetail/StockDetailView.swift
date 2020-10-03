//
//  StockDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import Combine

struct StockDetailView: View {

    let stock: StockDetail

    var companyInfo: [(key: String, image: String, value: String)] {  [
            ("Symbol", "textformat.abc", stock.symbol),
            ("Exchange", "dollarsign.square", stock.company.exchange),
            ("Industry", "wrench", stock.company.industry),
            ("CEO", "figure.wave", stock.company.ceo),
            ("Employees", "person.3", stock.company.employees.description),
            ("Country", "flag", stock.company.country),
        ]
    }

    var body: some View {
        List {
            AsyncImage(url: URL(string: "https://www.experimenta.es/wp-content/uploads/2018/10/tesla-logo.jpg")!) {
                ProgressView()
            }.padding()
            Section(header: Text("About")) {
                Text(stock.company.description)
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
        .navigationTitle(stock.companyName)
        .navigationBarItems(trailing: NavigationLink("Chart", destination: ChartView(stock: stock)))
    }
}

struct StockDetail_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(stock: StockDetail.random)
    }
}
