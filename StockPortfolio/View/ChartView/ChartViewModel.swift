//
//  StockDetailViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 30/09/2020.
//

import Foundation
import Combine

class ChartViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    @Published var chartData = [Double]() {
        didSet { calculateRate() }
    }
    @Published var percentageIncrease = 0

    private let api: APIProtocol
    private let dataStorage: DataStorage

    init(api: APIProtocol = API(),
         dataStorage: DataStorage = CoreDataStorage()) {
        self.api = api
        self.dataStorage = dataStorage
    }

    func chart(from symbol: String, selectedPeriod: Int) {
        let period = ChartPeriod.allCases[selectedPeriod]
        api.chart(from: symbol, period: period.rawValue, interval: period.interval).sink { result in
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
