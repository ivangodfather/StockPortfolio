//
//  CompanyDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import Combine

struct CompanyView: View {

    let symbol: String

    @StateObject private var viewModel = CompanyViewModel()
    var companyInfo: [(key: String, image: String, value: String)] {  [
        ("Symbol", "textformat.abc", viewModel.company!.symbol),
        ("Exchange", "dollarsign.square", viewModel.company!.exchange),
        ("Industry", "wrench", viewModel.company!.industry),
        ("CEO", "figure.wave", viewModel.company!.ceo),
        ("Employees", "person.3", viewModel.company!.employees.description),
        ("Country", "flag", viewModel.company!.country),
    ]
    }
    let rows: [GridItem] =  [
        GridItem(.flexible())
    ]
    var body: some View {
        if let logoURL = viewModel.logoURL, let company = viewModel.company {
            List {
                RemoteImage(url: logoURL)
                    .aspectRatio(contentMode: .fill)
                    .padding()
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows) {
                        if let tags = viewModel.company?.tags {
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
            .navigationTitle(symbol)
            .navigationBarItems(trailing: NavigationLink("Chart", destination: ChartView(symbol: symbol)))
        } else {
            ProgressView().onAppear {
                self.viewModel.requestCompanyData(from: symbol)
            }
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView(symbol: "AAPL")
    }
}
