//
//  ChartView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 02/10/2020.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    let symbol: String
    @StateObject private var viewModel = ChartViewModel()
    @State private var selectedPeriod = 0
    @State private var showChart = false

    var body: some View {
        VStack {
            Title("Chart")
            Picker(selection: $selectedPeriod, label: Text("Select")) {
                ForEach(0..<ChartPeriod.allCases.count) {
                    Text(ChartPeriod.allCases[$0].rawValue)
                }
            }.pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedPeriod) {
                viewModel.chart(from: symbol, selectedPeriod: $0)
            }
            .padding(.bottom)
            LineChartView(data: viewModel.chartData,
                          title: "",
                          form: CGSize(width:UIScreen.main.bounds.width - 48, height: 120),
                          rateValue: viewModel.percentageIncrease,
                          dropShadow: false)
        }
        .padding()
        .onAppear {
            viewModel.chart(from: symbol, selectedPeriod: selectedPeriod)
        }.navigationTitle("Chart")
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(symbol: "AAPL")
    }
}
