//
//  StockDetailViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation
import Combine

class StockDetailViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    @Published var chartData = [Double]() {
        didSet { calculateRate() }
    }
    @Published var percentageIncrease = 0

    private let api: API
    private let dataStorage: DataStorage

    init(api: API = API(),
         dataStorage: DataStorage = CoreDataStorage()) {
        self.api = api
        self.dataStorage = dataStorage
    }

    func chart(from symbol: String, selectedPeriod: Int) {
        api.chart(from: symbol, period: ChartPeriod.allCases[selectedPeriod].rawValue).sink { result in
            switch result {
            case .success(let chart): self.chartData = chart.map { $0.closePrize }
            case .failure(let error): print(error.localizedDescription)
            }
        }.store(in: &cancellables)
    }

    private func calculateRate() {
        guard let first = chartData.first, let last = chartData.last else {
            return
        }
        percentageIncrease = Int(last.percentage(from: first))
        
    }

}
