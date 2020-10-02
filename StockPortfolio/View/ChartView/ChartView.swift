//
//  ChartView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 02/10/2020.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    let stock: StockDetail
    @StateObject private var viewModel = ChartViewModel()
    @State private var selectedPeriod = 0
    @State private var showChart = false

    var body: some View {
        ScrollView {

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
        }.onAppear {
            viewModel.chart(from: stock.symbol, selectedPeriod: selectedPeriod)
        }.navigationTitle("Chart")
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(stock: StockDetail.random)
    }
}
