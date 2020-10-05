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
    func autcocomplete(from text: String) -> AnyPublisher<Result<[AutocompleteResult], APIError>, Never>
    func collections(type: String) -> AnyPublisher<Result<[Collection], APIError>, Never>
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
            .map { result in
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
        dataLoader.request(Endpoint<[IEXChart]>.chart(from: symbol, period: period)).map { result in
            switch result {
            case .success(let charts):
                return .success(charts.map(Chart.init(chart:)))
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }

    func news(from symbol: String, items: Int) -> AnyPublisher<Result<[News], APIError>, Never> {
        dataLoader.request(Endpoint<[IEXNews]>.news(from: symbol, items: items)).map { result in
            switch result {
            case .success(let news):
                return .success(news.map(News.init(news:)))
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }

    func autcocomplete(from text: String) -> AnyPublisher<Result<[AutocompleteResult], APIError>, Never> {
        dataLoader.request(Endpoint<RapidAPIAutocompleteResponse>.autocomplete(from: text)).map { result in
            switch result {
            case .success(let response):
                return .success(response.quotes.compactMap(AutocompleteResult.init))
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }

    func company(from symbol: String) -> AnyPublisher<Result<Company, APIError>, Never> {
        dataLoader.request(Endpoint<IEXCompany>.company(from: symbol)).map { result in
            switch result {
            case .success(let iexCompany):
                return .success(Company.init(iexCompany: iexCompany))
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }

    func collections(type: String) -> AnyPublisher<Result<[Collection], APIError>, Never> {
        dataLoader.request(Endpoint<[IEXCollection]>.collections(type: type)).map { result in
            switch result {
            case .success(let collections):
                return .success(collections.map(Collection.init(collection:)))
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }

    func collection(type: String, value: String) -> AnyPublisher<Result<[IEXStock.Quote], APIError>, Never> {
        dataLoader.request(Endpoint<[IEXStock.Quote]>.collection(type: type, value: value)).map { result in
            switch result {
            case .success(let stocks):
                return .success(stocks)
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }

    func logo(from symbol: String) -> AnyPublisher<Result<URL, APIError>, Never> {
        dataLoader.request(Endpoint<IEXCompany>.logo(from: symbol)).map { result in
            switch result {
            case .success(let iexLogo):
                return .success(iexLogo.url)
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }

}
