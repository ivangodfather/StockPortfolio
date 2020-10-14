//
//  StockAPI.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation
import Combine

protocol APIProtocol {
    func quotes(from symbols: [String]) -> AnyPublisher<Result<[Quote], APIError>, Never>
    func chart(from symbol: String, period: String, interval: String) -> AnyPublisher<Result<[Chart], APIError>, Never>
    func news(from symbol: String, items: Int) -> AnyPublisher<Result<[News], APIError>, Never>
    func search(from text: String) -> AnyPublisher<Result<[SearchResult], APIError>, Never>
    func marketInfo(listType: String) -> AnyPublisher<Result<[Quote], APIError>, Never>
    func logo(from symbol: String) -> AnyPublisher<Result<URL, APIError>, Never>
    func company(from symbol: String) -> AnyPublisher<Result<Company, APIError>, Never>
    func autcocomplete(from text: String) -> AnyPublisher<Result<[SearchResult], APIError>, Never>
    func companyDetail(from symbol: String) -> AnyPublisher<Result<CompanyDetail, APIError>, Never>
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

    func quotes(from symbols: [String]) -> AnyPublisher<Result<[Quote], APIError>, Never> {
        dataLoader.request(Endpoint<[String: IEXBatch]>.get(symbols: symbols))
            .map { result  in
                switch result {
                case .success(let valuesDictionary):
                    return .success(valuesDictionary.values.map(Quote.init(batch:)))
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }

    func chart(from symbol: String, period: String, interval: String) -> AnyPublisher<Result<[Chart], APIError>, Never> {
        dataLoader.request(Endpoint<[IEXChart]>.chart(from: symbol, period: period, interval: interval)).map { result in
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

    func search(from text: String) -> AnyPublisher<Result<[SearchResult], APIError>, Never> {
        dataLoader.request(Endpoint<[IEXSearchResult]>.search(from: text)).map { result in
            switch result {
            case .success(let response):
                return .success(response.compactMap(SearchResult.init))
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

    func marketInfo(listType: String) -> AnyPublisher<Result<[Quote], APIError>, Never> {
        dataLoader.request(Endpoint<[IEXBatch.Quote]>.marketInfo(listType: listType))
            .tryMap { result -> [IEXBatch.Quote] in
                do {
                    return try result.get()
                } catch {
                    throw APIError.unknown
                }
            }
            .flatMap { iexQuotes in
                logos(from: iexQuotes.map { $0.symbol }).tryMap { resultLogos -> [String: URL]  in
                    do {
                        return try resultLogos.get()
                    } catch {
                        throw APIError.unknown
                    }
                }
                .map { logosTuples in
                    iexQuotes.map { Quote(quote: $0, iexLogo: IEXLogo(url: logosTuples[$0.symbol] ?? URL(string: "")!))}
                }
            }
            .map {
                Result.success($0)
            }
            .replaceError(with: .failure(APIError.unknown))
            .eraseToAnyPublisher()
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

    func logos(from symbols: [String]) -> AnyPublisher<Result<[String: URL], APIError>, Never> {
        dataLoader.request(Endpoint<[String: IEXLogoResponse]>.logos(from: symbols)).map { result in
            switch result {
            case .success(let response):
                var valueToReturn = [String: URL]()
                response.forEach { key, value in
                    valueToReturn[key] = value.logo.url
                }
                return .success(valueToReturn)
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }

    func autcocomplete(from text: String) -> AnyPublisher<Result<[SearchResult], APIError>, Never> {
        dataLoader.request(Endpoint<RapidAPIAutocompleteResponse>.autocomplete(from: text)).map { result in
            switch result {
            case .success(let response):
                return .success(response.quotes.compactMap(SearchResult.init))
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }

    func companyDetail(from symbol: String) -> AnyPublisher<Result<CompanyDetail, APIError>, Never> {
        dataLoader.request(Endpoint<IEXCompany>.companyDetail(from: symbol)).map { result in
            switch result {
            case .success(let iexCompanyDetail):
                return .success(CompanyDetail(companyDetail: iexCompanyDetail))
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }

}
