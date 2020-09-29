//
//  StockAPI.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation
import Combine

protocol APIProtocol {
    func stocks(from symbols: [String]) -> AnyPublisher<Result<[Stock], APIError>, Never>
}

struct API: APIProtocol {

    private let dataLoader: DataLoader

    init(dataLoader: DataLoader = DataLoader()) {
        self.dataLoader = dataLoader
    }

    func stocks(from symbols: [String]) -> AnyPublisher<Result<[Stock], APIError>, Never> {
        dataLoader.request(Endpoint<[String: IEXStock]>.get(symbols: symbols)).map { result -> Result<[Stock], APIError> in
            switch result {
            case .success(let value):
                return .success(value.values.map(Stock.init(iexStock:)))
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }
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
