//
//  IEXStockAPI.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Combine
import Foundation

struct DataLoader {

    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: Endpoint<T>) -> AnyPublisher<Result<T, APIError>, Never> {
        return session
            .dataTaskPublisher(for: endpoint.urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                print(endpoint.urlRequest.debugDescription + " \(httpResponse.statusCode)" )

                guard 200...299 ~= httpResponse.statusCode else {
                    let reason = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    throw APIError.networkError(reason: reason)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .map { Result.success($0) }
            .catch { error -> Just<Result<T, APIError>> in
                print(error)
                if let urlError = error as? URLError {
                    return Just(Result.failure(APIError.networkError(reason: urlError.localizedDescription)))
                }
                if let decodingError = error as? DecodingError {
                    return Just(Result.failure(APIError.invalidJSON(reason: decodingError.localizedDescription)))
                }
                return Just(Result.failure(APIError.unknown))
            }
            .replaceError(with: .failure(APIError.unknown))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
