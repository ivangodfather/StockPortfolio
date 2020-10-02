//
//  StockAPI.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation
import Combine

protocol APIProtocol {
    func stocks(from stocks: [Stock]) -> AnyPublisher<Result<[StockDetail], APIError>, Never>
    func chart(from symbol: String, period: String) -> AnyPublisher<Result<[Chart], APIError>, Never>
    func news(from symbol: String, items: Int) -> AnyPublisher<Result<[News], APIError>, Never>
}

enum APIError: Error, LocalizedError {
    case invalidJSON(reason: String)
    case networkError(reason: String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .invalidJSON(let reason), .networkError(let reason):
            return reason
        }
    }
}

struct API: APIProtocol {

    private let dataLoader: DataLoader

    init(dataLoader: DataLoader = DataLoader()) {
        self.dataLoader = dataLoader
    }

    func stocks(from stocks: [Stock]) -> AnyPublisher<Result<[StockDetail], APIError>, Never> {
        dataLoader.request(Endpoint<[String: IEXStock]>.get(symbols: stocks.map { $0.symbol }))
            .map { result -> Result<[StockDetail], APIError> in
                switch result {
                case .success(let value):
                    return .success(value.values.map { iexStock -> StockDetail in
                        guard let shares = stocks.first(where: { $0.symbol == iexStock.quote.symbol })?.shares else {
                            preconditionFailure()
                        }

                        return StockDetail(iexStock: iexStock, shares: shares)
                    })
                    case .failure(let error):
                        return .failure(error)
                }
            }.eraseToAnyPublisher()
    }

    func chart(from symbol: String, period: String) -> AnyPublisher<Result<[Chart], APIError>, Never> {
        dataLoader.request(Endpoint<[IEXChart]>.chart(from: symbol, period: period)).map { result -> Result<[Chart], APIError> in
            switch result {
            case .success(let charts):
                return .success(charts.map(Chart.init(chart:)))
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }

    func news(from symbol: String, items: Int) -> AnyPublisher<Result<[News], APIError>, Never> {
        dataLoader.request(Endpoint<[News]>.news(from: symbol, items: items)).map { result -> Result<[News], APIError> in
            switch result {
            case .success(let news):
                return .success(news)
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }

}
