//
//  StockDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import SwiftUICharts
import Combine

struct StockDetailView: View {
    let stock: StockDetail

    @StateObject private var viewModel = StockDetailViewModel()
    @State private var selectedPeriod = 0

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
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    AsyncImage(url: stock.logo) {
                        ProgressView()
                    }.frame(width: 80, height: 100)
                    Spacer()
                    VStack(alignment: .leading) {
                        ForEach(companyInfo, id: \.self.0) { companyInfo in
                            HStack(alignment: .top, spacing: 4) {
                                Image(systemName: companyInfo.image)
                                Text("\(companyInfo.key): ")
                                Text("\(companyInfo.value)").bold()
                            }
                        }
                    }.font(.callout)
                }

                Text(stock.company.description)

                if !viewModel.chartData.isEmpty {
                    Picker(selection: $selectedPeriod, label: Text("Select")) {
                        ForEach(0..<ChartPeriod.allCases.count) {
                            Text(ChartPeriod.allCases[$0].rawValue)
                                .foregroundColor(Color.Stock.gray)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .onChange(of: selectedPeriod) {
                        viewModel.chart(from: stock.symbol, selectedPeriod: $0)
                    }
                    LineChartView(data: viewModel.chartData, title: "", form: ChartForm.large,rateValue: viewModel.percentageIncrease)
                } else {
                    Button {
                        viewModel.chart(from: stock.symbol, selectedPeriod: selectedPeriod)
                    } label: {
                        Text("View chart")
                    }
                }
                Divider().padding(.vertical, 16)
            }

        }
        .padding(32)
        .foregroundColor(Color.Stock.gray)
        .navigationTitle(stock.companyName)
    }
}

struct StockDetail_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(stock: StockDetail.random)
    }
}
