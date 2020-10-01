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
    var stock: StockDetail

    @StateObject private var viewModel = StockDetailViewModel()
    @State private var selectedPeriod = 0

    var body: some View {
        ScrollView {
            VStack() {
                Picker(selection: $selectedPeriod, label: Text("Select")) {
                    ForEach(0..<ChartPeriod.allCases.count) {
                        Text(ChartPeriod.allCases[$0].rawValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedPeriod) {
                    viewModel.chart(from: stock.symbol, selectedPeriod: $0)
                }
            }
            .padding()
            if !viewModel.chartData.isEmpty {
                LineChartView(data: viewModel.chartData, title: "", form: ChartForm.large,rateValue: viewModel.percentageIncrease)
            } else {
                ProgressView()
                .onAppear {
                    viewModel.chart(from: stock.symbol, selectedPeriod: selectedPeriod)
                }
            }
            Divider().padding(.vertical, 16)
            StockDetailNews(stock: stock)
        }
    }
}

struct StockDetail_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(stock: StockDetail.random)
    }
}
